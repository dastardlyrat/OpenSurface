// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TWIN_LANTERN_RAY_FXH
#define CAMERA_OBSCURA_API_TWIN_LANTERN_RAY_FXH

#include "../header/CAMERA_OBSCURA_EntryTraversal.fxh"

#define CAMERA_OBSCURA_API_TWIN_LANTERN_DIRECTION_COUNT 8.0

#define CAMERA_OBSCURA_API_TL03_INPUT_LIVE 0.0
#define CAMERA_OBSCURA_API_TL03_INPUT_INVALID_RECEIVER 1.0
#define CAMERA_OBSCURA_API_TL03_INPUT_ZERO_DIRECTION 2.0

struct CAMERA_OBSCURA_API_TwinLanternRayEvidence
{
    float requested_direction_index;
    float resolved_direction_index;
    float direction_index_valid;
    float2 direction_uv;
    float receiver_valid;
    float ray_valid;
    float2 origin_uv;
    float origin_depth;
    float2 endpoint_uv_requested;
    float2 endpoint_uv_resolved;
    float endpoint_screen_exit;
    float endpoint_depth;
    float depth_travel;
    float dda_hit;
    float dda_reason;
    float dda_step_index;
    float dda_terminal_depth;
    float march_hit;
    float march_reason;
    float march_step_index;
    float march_terminal_depth;
};

CAMERA_OBSCURA_API_TwinLanternRayEvidence
CAMERA_OBSCURA_API_DefaultTwinLanternRayEvidence()
{
    CAMERA_OBSCURA_API_TwinLanternRayEvidence evidence;
    evidence.requested_direction_index = 0.0;
    evidence.resolved_direction_index = 0.0;
    evidence.direction_index_valid = 0.0;
    evidence.direction_uv = float2(0.0, 0.0);
    evidence.receiver_valid = 0.0;
    evidence.ray_valid = 0.0;
    evidence.origin_uv = float2(0.0, 0.0);
    evidence.origin_depth = 0.0;
    evidence.endpoint_uv_requested = float2(0.0, 0.0);
    evidence.endpoint_uv_resolved = float2(0.0, 0.0);
    evidence.endpoint_screen_exit = 0.0;
    evidence.endpoint_depth = 0.0;
    evidence.depth_travel = 0.0;
    evidence.dda_hit = 0.0;
    evidence.dda_reason = CAMERA_OBSCURA_REASON_INVALID_RAY;
    evidence.dda_step_index = 0.0;
    evidence.dda_terminal_depth = 0.0;
    evidence.march_hit = 0.0;
    evidence.march_reason = CAMERA_OBSCURA_REASON_INVALID_RAY;
    evidence.march_step_index = 0.0;
    evidence.march_terminal_depth = 0.0;
    return evidence;
}

float CAMERA_OBSCURA_API_TwinLanternDirectionIndexValid(float index)
{
    float rounded = floor(index + 0.5);
    return
        step(0.0, index) *
        step(index, CAMERA_OBSCURA_API_TWIN_LANTERN_DIRECTION_COUNT - 1.0) *
        (1.0 - step(0.001, abs(index - rounded)));
}

float CAMERA_OBSCURA_API_TwinLanternResolveDirectionIndex(float index)
{
    return min(
        max(floor(index + 0.5), 0.0),
        CAMERA_OBSCURA_API_TWIN_LANTERN_DIRECTION_COUNT - 1.0);
}

float2 CAMERA_OBSCURA_API_TwinLanternDirection(float resolvedIndex)
{
    int index = (int)CAMERA_OBSCURA_API_TwinLanternResolveDirectionIndex(
        resolvedIndex);

    if (index == 0) return float2(1.0, 0.0);
    if (index == 1) return float2(0.70710678, 0.70710678);
    if (index == 2) return float2(0.0, 1.0);
    if (index == 3) return float2(-0.70710678, 0.70710678);
    if (index == 4) return float2(-1.0, 0.0);
    if (index == 5) return float2(-0.70710678, -0.70710678);
    if (index == 6) return float2(0.0, -1.0);
    return float2(0.70710678, -0.70710678);
}

CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildTL03Receiver(
    float2 uv,
    float inputMode)
{
    CAMERA_OBSCURA_SurfaceGuide guide;
    guide.valid = 0.0;
    guide.depth = 0.0;
    guide.normal = float3(0.0, 0.0, 1.0);
    guide.depth_confidence = 0.0;
    guide.edge_risk = 0.0;
    guide.luma = 0.0;

    if (inputMode < 0.5 || inputMode > 1.5)
    {
        float2 uvSafe = CAMERA_OBSCURA_SaturateUV(uv);
        float2 pixel = CAMERA_OBSCURA_PixelSize();
        float center = CAMERA_OBSCURA_LoadDepth(uvSafe);
        float left = CAMERA_OBSCURA_LoadDepth(
            CAMERA_OBSCURA_SaturateUV(uvSafe - float2(pixel.x, 0.0)));
        float right = CAMERA_OBSCURA_LoadDepth(
            CAMERA_OBSCURA_SaturateUV(uvSafe + float2(pixel.x, 0.0)));
        float down = CAMERA_OBSCURA_LoadDepth(
            CAMERA_OBSCURA_SaturateUV(uvSafe - float2(0.0, pixel.y)));
        float up = CAMERA_OBSCURA_LoadDepth(
            CAMERA_OBSCURA_SaturateUV(uvSafe + float2(0.0, pixel.y)));
        float depthSpread =
            abs(left - center) +
            abs(right - center) +
            abs(down - center) +
            abs(up - center);

        guide.valid = CAMERA_OBSCURA_DepthConfidence(center);
        guide.depth = center;
        guide.normal =
            guide.valid > 0.5 ?
            normalize(float3(
                center - right,
                center - up,
                max(pixel.x + pixel.y, 0.0001))) :
            float3(0.0, 0.0, 1.0);
        guide.edge_risk = saturate(depthSpread * 40.0);
        guide.depth_confidence = guide.valid * (1.0 - guide.edge_risk);
    }

    return guide;
}

CAMERA_OBSCURA_API_TwinLanternRayEvidence
CAMERA_OBSCURA_API_BuildTwinLanternRayEvidence(
    float2 uv,
    float requestedDirectionIndex,
    float inputMode,
    float rayLengthPixels,
    float depthSlope)
{
    CAMERA_OBSCURA_API_TwinLanternRayEvidence evidence =
        CAMERA_OBSCURA_API_DefaultTwinLanternRayEvidence();
    float resolvedIndex =
        CAMERA_OBSCURA_API_TwinLanternResolveDirectionIndex(
            requestedDirectionIndex);
    float directionIndexValid =
        CAMERA_OBSCURA_API_TwinLanternDirectionIndexValid(
            requestedDirectionIndex);
    float2 direction = CAMERA_OBSCURA_API_TwinLanternDirection(resolvedIndex);
    CAMERA_OBSCURA_SurfaceGuide receiver =
        CAMERA_OBSCURA_API_BuildTL03Receiver(uv, inputMode);
    CAMERA_OBSCURA_RayRequest request =
        CAMERA_OBSCURA_DefaultRayRequest(direction);

    if (inputMode > 1.5)
    {
        request.direction_uv = float2(0.0, 0.0);
    }
    else if (directionIndexValid < 0.5)
    {
        request.direction_uv = float2(0.0, 0.0);
    }

    request.ray_length_uv =
        max(rayLengthPixels, 0.0) *
        max(BUFFER_RCP_WIDTH, BUFFER_RCP_HEIGHT);
    request.ray_depth_slope = max(depthSlope, 0.0);
    request.requested_steps = CAMERA_OBSCURA_MARCH_MAX_STEPS;

    CAMERA_OBSCURA_TraceControls controls =
        CAMERA_OBSCURA_BuildTraceControls(request);
    CAMERA_OBSCURA_Ray ray = CAMERA_OBSCURA_BuildRayC0(
        CAMERA_OBSCURA_SaturateUV(uv),
        receiver,
        request,
        controls);

    // Both providers consume these exact request, control, and ray variables.
    CAMERA_OBSCURA_Hit dda = CAMERA_OBSCURA_RefineHit(
        ray,
        CAMERA_OBSCURA_TraceDDA(ray, controls),
        controls);
    CAMERA_OBSCURA_Hit march = CAMERA_OBSCURA_RefineHit(
        ray,
        CAMERA_OBSCURA_TraceMarch(ray, controls),
        controls);

    float2 endpointRequested = ray.origin_uv + ray.step_uv * ray.t_max;
    float2 endpointResolved = CAMERA_OBSCURA_SaturateUV(endpointRequested);

    evidence.requested_direction_index = requestedDirectionIndex;
    evidence.resolved_direction_index = resolvedIndex;
    evidence.direction_index_valid = directionIndexValid;
    evidence.direction_uv = request.direction_uv;
    evidence.receiver_valid = receiver.valid;
    evidence.ray_valid = ray.valid;
    evidence.origin_uv = ray.origin_uv;
    evidence.origin_depth = ray.origin_depth;
    evidence.endpoint_uv_requested = endpointRequested;
    evidence.endpoint_uv_resolved = endpointResolved;
    evidence.endpoint_screen_exit = step(
        0.000001,
        length(endpointRequested - endpointResolved));
    evidence.endpoint_depth = ray.origin_depth + ray.step_depth * ray.t_max;
    evidence.depth_travel = abs(ray.step_depth * ray.t_max);
    evidence.dda_hit = dda.hit;
    evidence.dda_reason = dda.reason;
    evidence.dda_step_index = dda.step_index;
    evidence.dda_terminal_depth = dda.scene_z;
    evidence.march_hit = march.hit;
    evidence.march_reason = march.reason;
    evidence.march_step_index = march.step_index;
    evidence.march_terminal_depth = march.scene_z;
    return evidence;
}

#endif // CAMERA_OBSCURA_API_TWIN_LANTERN_RAY_FXH
