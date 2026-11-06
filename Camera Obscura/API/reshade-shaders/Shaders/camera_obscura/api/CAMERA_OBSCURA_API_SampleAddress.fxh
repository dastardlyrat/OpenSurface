// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_SAMPLE_ADDRESS_FXH
#define CAMERA_OBSCURA_API_SAMPLE_ADDRESS_FXH

#include "../header/CAMERA_OBSCURA_AtomicCommon.fxh"

#define CAMERA_OBSCURA_API_SAMPLE_ADDRESS_VERSION 1

#define CAMERA_OBSCURA_API_ADDRESS_POLICY_REJECT 0
#define CAMERA_OBSCURA_API_ADDRESS_POLICY_CLAMP 1
#define CAMERA_OBSCURA_API_ADDRESS_POLICY_MIRROR 2
#define CAMERA_OBSCURA_API_ADDRESS_POLICY_WRAP 3

#define CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_NONE 0
#define CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_X 1
#define CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_Y 2
#define CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_CORNER 3

#define CAMERA_OBSCURA_API_ADDRESS_REASON_UNINITIALIZED 0
#define CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_FULL 1
#define CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_BORDER_FOOTPRINT 2
#define CAMERA_OBSCURA_API_ADDRESS_REASON_REJECTED_OUTSIDE 3
#define CAMERA_OBSCURA_API_ADDRESS_REASON_CLAMPED_OUTSIDE 4
#define CAMERA_OBSCURA_API_ADDRESS_REASON_MIRRORED_OUTSIDE 5
#define CAMERA_OBSCURA_API_ADDRESS_REASON_WRAPPED_OUTSIDE 6
#define CAMERA_OBSCURA_API_ADDRESS_REASON_NUMERIC_INVALID 7
#define CAMERA_OBSCURA_API_ADDRESS_REASON_UNKNOWN_POLICY 8

#ifndef CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON
#define CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON 0.000001
#endif

struct CAMERA_OBSCURA_API_SampleAddress
{
    float2 requested_uv;
    float2 resolved_uv;
    float2 footprint_half_uv;
    float requested_in_bounds;
    float resolved_in_bounds;
    float address_policy;
    float address_valid;
    float independent_evidence;
    float border_coverage;
    float outside_distance;
    float remapped;
    float duplicate_axis_count;
    float duplication_state;
    float confidence;
    float reason;
};

CAMERA_OBSCURA_API_SampleAddress CAMERA_OBSCURA_API_MakeSampleAddress()
{
    CAMERA_OBSCURA_API_SampleAddress address;
    address.requested_uv = float2(0.0, 0.0);
    address.resolved_uv = float2(0.0, 0.0);
    address.footprint_half_uv = float2(0.0, 0.0);
    address.requested_in_bounds = 0.0;
    address.resolved_in_bounds = 0.0;
    address.address_policy = CAMERA_OBSCURA_API_ADDRESS_POLICY_REJECT;
    address.address_valid = 0.0;
    address.independent_evidence = 0.0;
    address.border_coverage = 0.0;
    address.outside_distance = 0.0;
    address.remapped = 0.0;
    address.duplicate_axis_count = 0.0;
    address.duplication_state = CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_NONE;
    address.confidence = 0.0;
    address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_UNINITIALIZED;
    return address;
}

float CAMERA_OBSCURA_API_SampleAddressFinite(float value)
{
    return ((value == value) && (abs(value) < 1.0e19)) ? 1.0 : 0.0;
}

float CAMERA_OBSCURA_API_SampleAddressFinite2(float2 value)
{
    return
        CAMERA_OBSCURA_API_SampleAddressFinite(value.x) *
        CAMERA_OBSCURA_API_SampleAddressFinite(value.y);
}

float CAMERA_OBSCURA_API_SampleAddressInBounds(float2 uv)
{
    return
        step(0.0, uv.x) * step(uv.x, 1.0) *
        step(0.0, uv.y) * step(uv.y, 1.0);
}

float CAMERA_OBSCURA_API_SampleAddressPolicyKnown(float addressPolicy)
{
    float rounded = floor(addressPolicy + 0.5);
    return
        step(-0.5, rounded) *
        step(rounded, 3.5) *
        (1.0 - step(CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON, abs(addressPolicy - rounded)));
}

float CAMERA_OBSCURA_API_SampleAddressAxisCoverage(
    float requested,
    float footprintHalf)
{
    float coverage = 0.0;
    float halfWidth = abs(footprintHalf);

    if (halfWidth <= CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON)
    {
        coverage = step(0.0, requested) * step(requested, 1.0);
    }
    else
    {
        float low = requested - halfWidth;
        float high = requested + halfWidth;
        float overlap = max(0.0, min(high, 1.0) - max(low, 0.0));
        coverage = saturate(overlap / max(2.0 * halfWidth, CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON));
    }

    return coverage;
}

float2 CAMERA_OBSCURA_API_SampleAddressMirror01(float2 uv)
{
    float2 phase = frac(uv * 0.5);
    return 1.0 - abs(phase * 2.0 - 1.0);
}

float2 CAMERA_OBSCURA_API_SampleAddressWrap01(float2 uv)
{
    return frac(uv);
}

float CAMERA_OBSCURA_API_SampleAddressOutsideDistance(float2 requestedUv)
{
    float2 below = max(-requestedUv, 0.0);
    float2 above = max(requestedUv - 1.0, 0.0);
    return length(below + above);
}

float CAMERA_OBSCURA_API_SampleAddressEvidenceReady(
    CAMERA_OBSCURA_API_SampleAddress address,
    float coverageMinimum)
{
    float validGate = step(0.5, address.address_valid);
    float independentGate = step(0.5, address.independent_evidence);
    float confidenceGate = step(
        saturate(coverageMinimum),
        saturate(address.confidence));
    return validGate * independentGate * confidenceGate;
}

CAMERA_OBSCURA_API_SampleAddress CAMERA_OBSCURA_API_BuildSampleAddress(
    float2 requestedUv,
    float2 footprintHalfUv,
    float addressPolicy)
{
    CAMERA_OBSCURA_API_SampleAddress address = CAMERA_OBSCURA_API_MakeSampleAddress();
    float finite =
        CAMERA_OBSCURA_API_SampleAddressFinite2(requestedUv) *
        CAMERA_OBSCURA_API_SampleAddressFinite2(footprintHalfUv) *
        CAMERA_OBSCURA_API_SampleAddressFinite(addressPolicy);
    float policyKnown = CAMERA_OBSCURA_API_SampleAddressPolicyKnown(addressPolicy);

    address.requested_uv = requestedUv;
    address.footprint_half_uv = abs(footprintHalfUv);
    address.address_policy = addressPolicy;

    if (finite < 0.5)
    {
        address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_NUMERIC_INVALID;
    }
    else if (policyKnown < 0.5)
    {
        address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_UNKNOWN_POLICY;
    }
    else
    {
        float requestedInBounds = CAMERA_OBSCURA_API_SampleAddressInBounds(requestedUv);
        float coverageX = CAMERA_OBSCURA_API_SampleAddressAxisCoverage(
            requestedUv.x,
            address.footprint_half_uv.x);
        float coverageY = CAMERA_OBSCURA_API_SampleAddressAxisCoverage(
            requestedUv.y,
            address.footprint_half_uv.y);
        float borderCoverage = saturate(coverageX * coverageY);
        float roundedPolicy = floor(addressPolicy + 0.5);
        float2 resolvedUv = requestedUv;
        float addressValid = 0.0;

        if (roundedPolicy < 0.5)
        {
            resolvedUv = saturate(requestedUv);
            addressValid = requestedInBounds;
        }
        else if (roundedPolicy < 1.5)
        {
            resolvedUv = saturate(requestedUv);
            addressValid = 1.0;
        }
        else if (roundedPolicy < 2.5)
        {
            resolvedUv = requestedInBounds > 0.5
                ? requestedUv
                : CAMERA_OBSCURA_API_SampleAddressMirror01(requestedUv);
            addressValid = 1.0;
        }
        else
        {
            resolvedUv = requestedInBounds > 0.5
                ? requestedUv
                : CAMERA_OBSCURA_API_SampleAddressWrap01(requestedUv);
            addressValid = 1.0;
        }

        address.requested_in_bounds = requestedInBounds;
        address.resolved_uv = resolvedUv;
        address.resolved_in_bounds = CAMERA_OBSCURA_API_SampleAddressInBounds(resolvedUv);
        address.address_valid = addressValid * address.resolved_in_bounds;
        address.independent_evidence = requestedInBounds;
        address.border_coverage = borderCoverage;
        address.outside_distance = CAMERA_OBSCURA_API_SampleAddressOutsideDistance(requestedUv);
        address.remapped = step(
            CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON,
            max(abs(resolvedUv.x - requestedUv.x), abs(resolvedUv.y - requestedUv.y)));

        if ((roundedPolicy > 0.5) && (roundedPolicy < 1.5))
        {
            float duplicateX = 1.0 - step(0.999999, coverageX);
            float duplicateY = 1.0 - step(0.999999, coverageY);
            address.duplicate_axis_count = duplicateX + duplicateY;
            address.duplication_state = duplicateX + duplicateY * 2.0;
        }

        address.confidence = saturate(
            address.address_valid *
            address.independent_evidence *
            address.border_coverage);

        if (requestedInBounds > 0.5)
        {
            address.reason = borderCoverage < 0.999999
                ? CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_BORDER_FOOTPRINT
                : CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_FULL;
        }
        else if (roundedPolicy < 0.5)
        {
            address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_REJECTED_OUTSIDE;
        }
        else if (roundedPolicy < 1.5)
        {
            address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_CLAMPED_OUTSIDE;
        }
        else if (roundedPolicy < 2.5)
        {
            address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_MIRRORED_OUTSIDE;
        }
        else
        {
            address.reason = CAMERA_OBSCURA_API_ADDRESS_REASON_WRAPPED_OUTSIDE;
        }
    }

    return address;
}

float3 CAMERA_OBSCURA_API_SampleAddressReasonColor(float reason)
{
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_FULL)
        return float3(0.10, 1.00, 0.20);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_BORDER_FOOTPRINT)
        return float3(1.00, 0.55, 0.05);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_REJECTED_OUTSIDE)
        return float3(1.00, 0.05, 0.05);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_CLAMPED_OUTSIDE)
        return float3(0.05, 0.30, 1.00);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_MIRRORED_OUTSIDE)
        return float3(0.00, 0.90, 0.90);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_WRAPPED_OUTSIDE)
        return float3(0.75, 0.10, 1.00);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_NUMERIC_INVALID)
        return float3(1.00, 0.05, 0.75);
    if (reason == CAMERA_OBSCURA_API_ADDRESS_REASON_UNKNOWN_POLICY)
        return float3(1.00, 0.90, 0.05);
    return float3(0.0, 0.0, 0.0);
}

float3 CAMERA_OBSCURA_API_SampleAddressPolicyColor(float policy)
{
    if (policy < 0.5)
        return float3(1.00, 0.05, 0.05);
    if (policy < 1.5)
        return float3(0.05, 0.30, 1.00);
    if (policy < 2.5)
        return float3(0.00, 0.90, 0.90);
    if (policy < 3.5)
        return float3(0.75, 0.10, 1.00);
    return float3(1.00, 0.90, 0.05);
}

float3 CAMERA_OBSCURA_API_SampleAddressDuplicationColor(float state)
{
    if (state == CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_X)
        return float3(1.0, 0.0, 0.0);
    if (state == CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_Y)
        return float3(0.0, 1.0, 0.0);
    if (state == CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_CORNER)
        return float3(1.0, 1.0, 0.0);
    return float3(0.0, 0.0, 0.0);
}

float3 CAMERA_OBSCURA_API_SampleAddressDebugView(
    CAMERA_OBSCURA_API_SampleAddress address,
    float view,
    float coverageMinimum)
{
    if (view < 0.5)
        return float3(
            saturate(address.requested_uv.x),
            saturate(address.requested_uv.y),
            address.requested_in_bounds);
    if (view < 1.5)
        return float3(
            saturate(address.resolved_uv.x),
            saturate(address.resolved_uv.y),
            address.resolved_in_bounds);
    if (view < 2.5)
        return address.requested_in_bounds.xxx;
    if (view < 3.5)
        return address.resolved_in_bounds.xxx;
    if (view < 4.5)
        return address.address_valid.xxx;
    if (view < 5.5)
        return address.independent_evidence.xxx;
    if (view < 6.5)
        return saturate(address.border_coverage).xxx;
    if (view < 7.5)
        return saturate(address.outside_distance * 10.0).xxx;
    if (view < 8.5)
        return address.remapped.xxx;
    if (view < 9.5)
        return CAMERA_OBSCURA_API_SampleAddressDuplicationColor(
            address.duplication_state);
    if (view < 10.5)
        return saturate(address.duplicate_axis_count * 0.5).xxx;
    if (view < 11.5)
        return saturate(address.confidence).xxx;
    if (view < 12.5)
        return CAMERA_OBSCURA_API_SampleAddressReasonColor(address.reason);
    if (view < 13.5)
        return CAMERA_OBSCURA_API_SampleAddressPolicyColor(address.address_policy);
    return CAMERA_OBSCURA_API_SampleAddressEvidenceReady(
        address,
        coverageMinimum).xxx;
}

#endif // CAMERA_OBSCURA_API_SAMPLE_ADDRESS_FXH
