// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TWIN_LANTERN_PARITY_FXH
#define CAMERA_OBSCURA_API_TWIN_LANTERN_PARITY_FXH

#include "CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh"
#include "../header/CAMERA_OBSCURA_EntryTraversal.fxh"

struct CAMERA_OBSCURA_API_TwinLanternParityEvidence
{
    float direction_index;
    float ray_valid;
    float2 direction_uv;
    float2 endpoint_uv_requested;
    float2 endpoint_uv_resolved;
    float endpoint_depth;
    float dda_hit;
    float dda_reason;
    float dda_confidence;
    float2 dda_uv;
    float dda_depth;
    float dda_distance_pixels;
    float dda_step_index;
    float march_hit;
    float march_reason;
    float march_confidence;
    float2 march_uv;
    float march_depth;
    float march_distance_pixels;
    float march_step_index;
    float both_hit;
    float dda_only;
    float march_only;
    float neither_hit;
    float uv_delta_pixels;
    float depth_delta;
    float distance_delta_pixels;
    float uv_agreement;
    float depth_agreement;
    float distance_agreement;
    float conflict;
};

CAMERA_OBSCURA_API_TwinLanternParityEvidence
CAMERA_OBSCURA_API_DefaultTwinLanternParityEvidence()
{
    CAMERA_OBSCURA_API_TwinLanternParityEvidence evidence;
    evidence.direction_index = 0.0;
    evidence.ray_valid = 0.0;
    evidence.direction_uv = float2(0.0, 0.0);
    evidence.endpoint_uv_requested = float2(0.0, 0.0);
    evidence.endpoint_uv_resolved = float2(0.0, 0.0);
    evidence.endpoint_depth = 0.0;
    evidence.dda_hit = 0.0;
    evidence.dda_reason = CAMERA_OBSCURA_REASON_INVALID_RAY;
    evidence.dda_confidence = 0.0;
    evidence.dda_uv = float2(0.0, 0.0);
    evidence.dda_depth = 0.0;
    evidence.dda_distance_pixels = 0.0;
    evidence.dda_step_index = 0.0;
    evidence.march_hit = 0.0;
    evidence.march_reason = CAMERA_OBSCURA_REASON_INVALID_RAY;
    evidence.march_confidence = 0.0;
    evidence.march_uv = float2(0.0, 0.0);
    evidence.march_depth = 0.0;
    evidence.march_distance_pixels = 0.0;
    evidence.march_step_index = 0.0;
    evidence.both_hit = 0.0;
    evidence.dda_only = 0.0;
    evidence.march_only = 0.0;
    evidence.neither_hit = 1.0;
    evidence.uv_delta_pixels = 0.0;
    evidence.depth_delta = 0.0;
    evidence.distance_delta_pixels = 0.0;
    evidence.uv_agreement = 0.0;
    evidence.depth_agreement = 0.0;
    evidence.distance_agreement = 0.0;
    evidence.conflict = 0.0;
    return evidence;
}

CAMERA_OBSCURA_API_TwinLanternParityEvidence
CAMERA_OBSCURA_API_BuildTwinLanternParityEvidence(
    float2 uv,
    float directionIndex,
    float inputMode,
    float rayLengthPixels,
    float depthSlope,
    float frontBias,
    float backThickness,
    float uvTolerancePixels,
    float depthTolerance,
    float distanceTolerancePixels)
{
    CAMERA_OBSCURA_API_TwinLanternParityEvidence evidence =
        CAMERA_OBSCURA_API_DefaultTwinLanternParityEvidence();
    CAMERA_OBSCURA_TraceControls controls;
    CAMERA_OBSCURA_SurfaceGuide receiver;
    CAMERA_OBSCURA_Ray ray = CAMERA_OBSCURA_API_BuildTL45Ray(
        uv,
        directionIndex,
        inputMode,
        CAMERA_OBSCURA_DDA_MAX_STEPS,
        min(max(rayLengthPixels, 1.0), (float)CAMERA_OBSCURA_DDA_MAX_STEPS),
        depthSlope,
        frontBias,
        backThickness,
        controls,
        receiver);

    // The exact same ray and control variables are dispatched to both providers.
    CAMERA_OBSCURA_Hit ddaCoarse = CAMERA_OBSCURA_TraceDDA(ray, controls);
    CAMERA_OBSCURA_Hit dda = CAMERA_OBSCURA_RefineHit(
        ray,
        ddaCoarse,
        controls);
    CAMERA_OBSCURA_Hit marchCoarse = CAMERA_OBSCURA_TraceMarch(ray, controls);
    CAMERA_OBSCURA_Hit march = CAMERA_OBSCURA_RefineHit(
        ray,
        marchCoarse,
        controls);

    float2 pixel = max(
        CAMERA_OBSCURA_PixelSize(),
        float2(0.000001, 0.000001));
    float2 endpointRequested = ray.origin_uv + ray.step_uv * ray.t_max;
    float ddaDistance = length((dda.uv - ray.origin_uv) / pixel);
    float marchDistance = length((march.uv - ray.origin_uv) / pixel);
    float bothHit = min(dda.hit, march.hit);
    float ddaOnly = dda.hit * (1.0 - march.hit);
    float marchOnly = march.hit * (1.0 - dda.hit);
    float neitherHit = (1.0 - dda.hit) * (1.0 - march.hit);
    float uvDelta = length((dda.uv - march.uv) / pixel) * bothHit;
    float depthDelta = abs(dda.scene_z - march.scene_z) * bothHit;
    float distanceDelta = abs(ddaDistance - marchDistance) * bothHit;
    float safeUvTolerance = max(uvTolerancePixels, 0.000001);
    float safeDepthTolerance = max(depthTolerance, 0.000001);
    float safeDistanceTolerance = max(distanceTolerancePixels, 0.000001);
    float uvAgreement = bothHit * saturate(
        1.0 - uvDelta / safeUvTolerance);
    float depthAgreement = bothHit * saturate(
        1.0 - depthDelta / safeDepthTolerance);
    float distanceAgreement = bothHit * saturate(
        1.0 - distanceDelta / safeDistanceTolerance);
    float conflict = bothHit * max(
        step(safeUvTolerance + 0.000001, uvDelta),
        max(
            step(safeDepthTolerance + 0.000001, depthDelta),
            step(safeDistanceTolerance + 0.000001, distanceDelta)));

    evidence.direction_index = min(max(floor(directionIndex + 0.5), 0.0), 7.0);
    evidence.ray_valid = ray.valid;
    evidence.direction_uv = ray.step_uv *
        CAMERA_OBSCURA_SafeRcp(length(ray.step_uv), 0.0);
    evidence.endpoint_uv_requested = endpointRequested;
    evidence.endpoint_uv_resolved = CAMERA_OBSCURA_SaturateUV(endpointRequested);
    evidence.endpoint_depth = ray.origin_depth + ray.step_depth * ray.t_max;
    evidence.dda_hit = dda.hit;
    evidence.dda_reason = dda.reason;
    evidence.dda_confidence = dda.confidence;
    evidence.dda_uv = dda.uv;
    evidence.dda_depth = dda.scene_z;
    evidence.dda_distance_pixels = ddaDistance;
    evidence.dda_step_index = dda.step_index;
    evidence.march_hit = march.hit;
    evidence.march_reason = march.reason;
    evidence.march_confidence = march.confidence;
    evidence.march_uv = march.uv;
    evidence.march_depth = march.scene_z;
    evidence.march_distance_pixels = marchDistance;
    evidence.march_step_index = march.step_index;
    evidence.both_hit = bothHit;
    evidence.dda_only = ddaOnly;
    evidence.march_only = marchOnly;
    evidence.neither_hit = neitherHit;
    evidence.uv_delta_pixels = uvDelta;
    evidence.depth_delta = depthDelta;
    evidence.distance_delta_pixels = distanceDelta;
    evidence.uv_agreement = uvAgreement;
    evidence.depth_agreement = depthAgreement;
    evidence.distance_agreement = distanceAgreement;
    evidence.conflict = conflict;
    return evidence;
}

#endif // CAMERA_OBSCURA_API_TWIN_LANTERN_PARITY_FXH
