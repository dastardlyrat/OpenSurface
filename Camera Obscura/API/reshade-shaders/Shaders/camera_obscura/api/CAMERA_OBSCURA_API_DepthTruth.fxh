// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_DEPTH_TRUTH_FXH
#define CAMERA_OBSCURA_API_DEPTH_TRUTH_FXH

#include "../header/CAMERA_OBSCURA_AtomicCommon.fxh"

#define CAMERA_OBSCURA_API_DEPTH_TRUTH_VERSION 1

#define CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NONE 0
#define CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NEAR 1
#define CAMERA_OBSCURA_API_DEPTH_ENDPOINT_FAR_OR_SKY 2
#define CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NUMERIC_INVALID 3

#define CAMERA_OBSCURA_API_DEPTH_REASON_UNINITIALIZED 0
#define CAMERA_OBSCURA_API_DEPTH_REASON_VALID_FLAT 1
#define CAMERA_OBSCURA_API_DEPTH_REASON_VALID_EDGE 2
#define CAMERA_OBSCURA_API_DEPTH_REASON_UNAVAILABLE 3
#define CAMERA_OBSCURA_API_DEPTH_REASON_INVALID_SAMPLE 4
#define CAMERA_OBSCURA_API_DEPTH_REASON_NEAR_ENDPOINT 5
#define CAMERA_OBSCURA_API_DEPTH_REASON_FAR_OR_SKY 6

#ifndef CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON
#define CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON 0.000001
#endif

#ifndef CAMERA_OBSCURA_API_DEPTH_TRUTH_EDGE_SCALE
#define CAMERA_OBSCURA_API_DEPTH_TRUTH_EDGE_SCALE 40.0
#endif

struct CAMERA_OBSCURA_API_DepthTruth
{
    float capability_available;
    float acquisition_attempted;
    float sample_valid;
    float depth_value;
    float depth_metric;
    float endpoint_or_sky_state;
    float local_activity;
    float edge_risk;
    float confidence;
    float authority;
    float reason;
    float depth_reads;
};

CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_MakeDepthTruth()
{
    CAMERA_OBSCURA_API_DepthTruth truth;
    truth.capability_available = 0.0;
    truth.acquisition_attempted = 0.0;
    truth.sample_valid = 0.0;
    truth.depth_value = 0.0;
    truth.depth_metric = CAMERA_OBSCURA_DEPTH_METRIC_NONE;
    truth.endpoint_or_sky_state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NONE;
    truth.local_activity = 0.0;
    truth.edge_risk = 0.0;
    truth.confidence = 0.0;
    truth.authority = 0.0;
    truth.reason = CAMERA_OBSCURA_API_DEPTH_REASON_UNINITIALIZED;
    truth.depth_reads = 0.0;
    return truth;
}

float CAMERA_OBSCURA_API_DepthTruthFinite(float value)
{
    return ((value == value) && (abs(value) < 1.0e19)) ? 1.0 : 0.0;
}

float CAMERA_OBSCURA_API_DepthTruthSampleValid(float depth)
{
    float finite = CAMERA_OBSCURA_API_DepthTruthFinite(depth);
    float aboveNear = step(
        CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON,
        depth);
    float belowFar = step(
        depth,
        1.0 - CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON);
    return finite * aboveNear * belowFar;
}

float CAMERA_OBSCURA_API_DepthTruthEndpointState(float depth)
{
    float finite = CAMERA_OBSCURA_API_DepthTruthFinite(depth);
    float state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NONE;

    if (finite < 0.5)
    {
        state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NUMERIC_INVALID;
    }
    else if ((depth < 0.0) || (depth > 1.0))
    {
        state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NUMERIC_INVALID;
    }
    else if (depth <= CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON)
    {
        state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NEAR;
    }
    else if (depth >= 1.0 - CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON)
    {
        state = CAMERA_OBSCURA_API_DEPTH_ENDPOINT_FAR_OR_SKY;
    }

    return state;
}

float CAMERA_OBSCURA_API_DepthTruthAuthority(
    float capabilityAvailable,
    float sampleValid,
    float confidence)
{
    return saturate(
        saturate(capabilityAvailable) *
        saturate(sampleValid) *
        saturate(confidence));
}

float CAMERA_OBSCURA_API_DepthTruthReady(
    CAMERA_OBSCURA_API_DepthTruth truth,
    float confidenceMinimum)
{
    float capabilityGate = step(0.5, truth.capability_available);
    float validityGate = step(0.5, truth.sample_valid);
    float confidenceGate = step(
        saturate(confidenceMinimum),
        saturate(truth.confidence));
    return capabilityGate * validityGate * confidenceGate;
}

CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
    float capabilityAvailable,
    float acquisitionAttempted,
    float depthMetric,
    float centerDepth,
    float leftDepth,
    float rightDepth,
    float downDepth,
    float upDepth,
    float depthReads)
{
    CAMERA_OBSCURA_API_DepthTruth truth = CAMERA_OBSCURA_API_MakeDepthTruth();
    float centerValid = CAMERA_OBSCURA_API_DepthTruthSampleValid(centerDepth);
    float leftValid = CAMERA_OBSCURA_API_DepthTruthSampleValid(leftDepth);
    float rightValid = CAMERA_OBSCURA_API_DepthTruthSampleValid(rightDepth);
    float downValid = CAMERA_OBSCURA_API_DepthTruthSampleValid(downDepth);
    float upValid = CAMERA_OBSCURA_API_DepthTruthSampleValid(upDepth);

    float leftDelta = abs(leftDepth - centerDepth) * leftValid;
    float rightDelta = abs(rightDepth - centerDepth) * rightValid;
    float downDelta = abs(downDepth - centerDepth) * downValid;
    float upDelta = abs(upDepth - centerDepth) * upValid;
    float localActivity = max(
        max(leftDelta, rightDelta),
        max(downDelta, upDelta));
    float edgeRisk = centerValid * saturate(
        localActivity * CAMERA_OBSCURA_API_DEPTH_TRUTH_EDGE_SCALE);
    float confidence = centerValid * saturate(1.0 - edgeRisk * 0.5);
    float endpointState = CAMERA_OBSCURA_API_DepthTruthEndpointState(centerDepth);
    float reason = CAMERA_OBSCURA_API_DEPTH_REASON_INVALID_SAMPLE;

    if (capabilityAvailable < 0.5)
    {
        reason = CAMERA_OBSCURA_API_DEPTH_REASON_UNAVAILABLE;
    }
    else if (endpointState == CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NEAR)
    {
        reason = CAMERA_OBSCURA_API_DEPTH_REASON_NEAR_ENDPOINT;
    }
    else if (endpointState == CAMERA_OBSCURA_API_DEPTH_ENDPOINT_FAR_OR_SKY)
    {
        reason = CAMERA_OBSCURA_API_DEPTH_REASON_FAR_OR_SKY;
    }
    else if (centerValid > 0.5)
    {
        reason =
            edgeRisk > 0.000001 ?
            CAMERA_OBSCURA_API_DEPTH_REASON_VALID_EDGE :
            CAMERA_OBSCURA_API_DEPTH_REASON_VALID_FLAT;
    }

    truth.capability_available = saturate(capabilityAvailable);
    truth.acquisition_attempted = saturate(acquisitionAttempted);
    truth.sample_valid = centerValid * truth.capability_available;
    truth.depth_value = centerDepth;
    truth.depth_metric =
        truth.capability_available > 0.5 ?
        depthMetric :
        CAMERA_OBSCURA_DEPTH_METRIC_NONE;
    truth.endpoint_or_sky_state = endpointState;
    truth.local_activity = truth.sample_valid * localActivity;
    truth.edge_risk = truth.sample_valid * edgeRisk;
    truth.confidence = truth.sample_valid * confidence;
    truth.authority = CAMERA_OBSCURA_API_DepthTruthAuthority(
        truth.capability_available,
        truth.sample_valid,
        truth.confidence);
    truth.reason = reason;
    truth.depth_reads = max(depthReads, 0.0);
    return truth;
}

CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthUnavailable()
{
    CAMERA_OBSCURA_API_DepthTruth truth = CAMERA_OBSCURA_API_MakeDepthTruth();
    truth.reason = CAMERA_OBSCURA_API_DEPTH_REASON_UNAVAILABLE;
    return truth;
}

CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthLiveAvailable(
    float2 uv,
    float depthMetric)
{
    float2 uvSafe = CAMERA_OBSCURA_SaturateUV(uv);
    float2 pixel = CAMERA_OBSCURA_PixelSize();
    float centerDepth = saturate(ReShade::GetLinearizedDepth(uvSafe));
    float leftDepth = saturate(ReShade::GetLinearizedDepth(
        CAMERA_OBSCURA_SaturateUV(uvSafe - float2(pixel.x, 0.0))));
    float rightDepth = saturate(ReShade::GetLinearizedDepth(
        CAMERA_OBSCURA_SaturateUV(uvSafe + float2(pixel.x, 0.0))));
    float downDepth = saturate(ReShade::GetLinearizedDepth(
        CAMERA_OBSCURA_SaturateUV(uvSafe - float2(0.0, pixel.y))));
    float upDepth = saturate(ReShade::GetLinearizedDepth(
        CAMERA_OBSCURA_SaturateUV(uvSafe + float2(0.0, pixel.y))));

    return CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
        1.0,
        1.0,
        depthMetric,
        centerDepth,
        leftDepth,
        rightDepth,
        downDepth,
        upDepth,
        5.0);
}

CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthSynthetic(
    float syntheticMode)
{
    CAMERA_OBSCURA_API_DepthTruth truth = CAMERA_OBSCURA_API_MakeDepthTruth();

    if (syntheticMode < 0.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthUnavailable();
    }
    else if (syntheticMode < 1.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
            1.0, 0.0, CAMERA_OBSCURA_DEPTH_METRIC_LINEAR01,
            -1.0, -1.0, -1.0, -1.0, -1.0, 0.0);
    }
    else if (syntheticMode < 2.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
            1.0, 0.0, CAMERA_OBSCURA_DEPTH_METRIC_LINEAR01,
            0.5, 0.5, 0.5, 0.5, 0.5, 0.0);
    }
    else if (syntheticMode < 3.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
            1.0, 0.0, CAMERA_OBSCURA_DEPTH_METRIC_LINEAR01,
            0.25, 0.25, 0.75, 0.25, 0.25, 0.0);
    }
    else if (syntheticMode < 4.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
            1.0, 0.0, CAMERA_OBSCURA_DEPTH_METRIC_LINEAR01,
            0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    }
    else if (syntheticMode < 5.5)
    {
        truth = CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(
            1.0, 0.0, CAMERA_OBSCURA_DEPTH_METRIC_LINEAR01,
            1.0, 1.0, 1.0, 1.0, 1.0, 0.0);
    }

    return truth;
}

float3 CAMERA_OBSCURA_API_DepthTruthReasonColor(float reason)
{
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_VALID_FLAT)
        return float3(0.15, 0.85, 0.20);
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_VALID_EDGE)
        return float3(1.00, 0.55, 0.05);
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_UNAVAILABLE)
        return float3(0.10, 0.35, 1.00);
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_INVALID_SAMPLE)
        return float3(1.00, 0.05, 0.75);
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_NEAR_ENDPOINT)
        return float3(0.00, 0.90, 0.90);
    if (reason == CAMERA_OBSCURA_API_DEPTH_REASON_FAR_OR_SKY)
        return float3(1.00, 0.90, 0.05);
    return float3(0.0, 0.0, 0.0);
}

float3 CAMERA_OBSCURA_API_DepthTruthEndpointColor(float endpointState)
{
    if (endpointState == CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NEAR)
        return float3(0.00, 0.90, 0.90);
    if (endpointState == CAMERA_OBSCURA_API_DEPTH_ENDPOINT_FAR_OR_SKY)
        return float3(1.00, 0.90, 0.05);
    if (endpointState == CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NUMERIC_INVALID)
        return float3(1.00, 0.05, 0.75);
    return float3(0.0, 0.0, 0.0);
}

float3 CAMERA_OBSCURA_API_DepthTruthDebugView(
    CAMERA_OBSCURA_API_DepthTruth truth,
    float view,
    float confidenceMinimum)
{
    if (view < 0.5)
        return truth.capability_available.xxx;
    if (view < 1.5)
        return truth.acquisition_attempted.xxx;
    if (view < 2.5)
        return truth.sample_valid.xxx;
    if (view < 3.5)
        return saturate(truth.depth_value).xxx;
    if (view < 4.5)
        return saturate(truth.depth_metric * 0.25).xxx;
    if (view < 5.5)
        return CAMERA_OBSCURA_API_DepthTruthEndpointColor(
            truth.endpoint_or_sky_state);
    if (view < 6.5)
        return saturate(truth.local_activity * 40.0).xxx;
    if (view < 7.5)
        return saturate(truth.edge_risk).xxx;
    if (view < 8.5)
        return saturate(truth.confidence).xxx;
    if (view < 9.5)
        return saturate(truth.authority).xxx;
    if (view < 10.5)
        return CAMERA_OBSCURA_API_DepthTruthReasonColor(truth.reason);
    if (view < 11.5)
        return saturate(truth.depth_reads * 0.2).xxx;
    return CAMERA_OBSCURA_API_DepthTruthReady(
        truth,
        confidenceMinimum).xxx;
}

#endif // CAMERA_OBSCURA_API_DEPTH_TRUTH_FXH
