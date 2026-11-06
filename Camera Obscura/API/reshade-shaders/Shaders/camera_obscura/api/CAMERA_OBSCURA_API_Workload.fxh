// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_WORKLOAD_FXH
#define CAMERA_OBSCURA_API_WORKLOAD_FXH

#include "../header/CAMERA_OBSCURA_AtomicCommon.fxh"

#define CAMERA_OBSCURA_API_WORKLOAD_VERSION 1

#define CAMERA_OBSCURA_API_WORKLOAD_REASON_UNINITIALIZED 0
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_ACTIVE 1
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_OUTPUT_ONLY_BYPASS 2
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_WORKLOAD_BYPASS 3
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_CAPABILITY_UNAVAILABLE 4
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_AUTHORITY 5
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_REQUEST 6
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_ACTIVE 7
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_COUNTER_INVALID 8
#define CAMERA_OBSCURA_API_WORKLOAD_REASON_NUMERIC_INVALID 9

#ifndef CAMERA_OBSCURA_API_WORKLOAD_EPSILON
#define CAMERA_OBSCURA_API_WORKLOAD_EPSILON 0.000001
#endif

struct CAMERA_OBSCURA_API_Workload
{
    float requested_units;
    float policy_capped_units;
    float hard_capped_units;
    float capped_units;
    float active_units;
    float unique_units;
    float executed_units;
    float rejected_units;
    float refined_units;
    float reused_units;
    float duplicate_units;
    float physical_units;
    float capability_available;
    float authority;
    float output_bypass;
    float workload_bypass_requested;
    float workload_bypass_effective;
    float work_allowed;
    float counters_valid;
    float reason;
};

CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_MakeWorkload()
{
    CAMERA_OBSCURA_API_Workload workload;
    workload.requested_units = 0.0;
    workload.policy_capped_units = 0.0;
    workload.hard_capped_units = 0.0;
    workload.capped_units = 0.0;
    workload.active_units = 0.0;
    workload.unique_units = 0.0;
    workload.executed_units = 0.0;
    workload.rejected_units = 0.0;
    workload.refined_units = 0.0;
    workload.reused_units = 0.0;
    workload.duplicate_units = 0.0;
    workload.physical_units = 0.0;
    workload.capability_available = 0.0;
    workload.authority = 0.0;
    workload.output_bypass = 0.0;
    workload.workload_bypass_requested = 0.0;
    workload.workload_bypass_effective = 1.0;
    workload.work_allowed = 0.0;
    workload.counters_valid = 0.0;
    workload.reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_UNINITIALIZED;
    return workload;
}

float CAMERA_OBSCURA_API_WorkloadFinite(float value)
{
    return ((value == value) && (abs(value) < 1.0e19)) ? 1.0 : 0.0;
}

float CAMERA_OBSCURA_API_WorkloadCount(float value)
{
    return max(floor(value + 0.5), 0.0);
}

float CAMERA_OBSCURA_API_WorkloadApprox(float value, float expected, float epsilon)
{
    return 1.0 - step(max(epsilon, CAMERA_OBSCURA_API_WORKLOAD_EPSILON), abs(value - expected));
}

CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_BuildWorkload(
    float requestedUnits,
    float policyCapUnits,
    float hardCapUnits,
    float activeUnits,
    float uniqueUnits,
    float executedUnits,
    float rejectedUnits,
    float refinedUnits,
    float reusedUnits,
    float capabilityAvailable,
    float authority,
    float outputBypass,
    float workloadBypassRequested)
{
    CAMERA_OBSCURA_API_Workload workload = CAMERA_OBSCURA_API_MakeWorkload();

    float finite =
        CAMERA_OBSCURA_API_WorkloadFinite(requestedUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(policyCapUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(hardCapUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(activeUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(uniqueUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(executedUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(rejectedUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(refinedUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(reusedUnits) *
        CAMERA_OBSCURA_API_WorkloadFinite(capabilityAvailable) *
        CAMERA_OBSCURA_API_WorkloadFinite(authority) *
        CAMERA_OBSCURA_API_WorkloadFinite(outputBypass) *
        CAMERA_OBSCURA_API_WorkloadFinite(workloadBypassRequested);

    float nonnegative =
        step(0.0, requestedUnits) *
        step(0.0, policyCapUnits) *
        step(0.0, hardCapUnits) *
        step(0.0, activeUnits) *
        step(0.0, uniqueUnits) *
        step(0.0, executedUnits) *
        step(0.0, rejectedUnits) *
        step(0.0, refinedUnits) *
        step(0.0, reusedUnits);

    float requested = CAMERA_OBSCURA_API_WorkloadCount(requestedUnits);
    float policyCap = min(requested, CAMERA_OBSCURA_API_WorkloadCount(policyCapUnits));
    float hardCap = min(requested, CAMERA_OBSCURA_API_WorkloadCount(hardCapUnits));
    float capped = min(policyCap, hardCap);
    float active = min(CAMERA_OBSCURA_API_WorkloadCount(activeUnits), capped);

    float declaredUnique = CAMERA_OBSCURA_API_WorkloadCount(uniqueUnits);
    float declaredExecuted = CAMERA_OBSCURA_API_WorkloadCount(executedUnits);
    float declaredRejected = CAMERA_OBSCURA_API_WorkloadCount(rejectedUnits);
    float declaredRefined = CAMERA_OBSCURA_API_WorkloadCount(refinedUnits);
    float declaredReused = CAMERA_OBSCURA_API_WorkloadCount(reusedUnits);

    float partition = declaredExecuted + declaredRejected + declaredReused;
    float partitionValid = CAMERA_OBSCURA_API_WorkloadApprox(partition, active, 0.0001);
    float executedBound = step(declaredExecuted, active);
    float rejectedBound = step(declaredRejected, active);
    float reusedBound = step(declaredReused, active);
    float uniqueBound = step(declaredUnique, declaredExecuted);
    float refinementValid =
        (1.0 - step(0.5, declaredRefined)) +
        step(0.5, declaredExecuted) * step(0.5, declaredRefined);
    refinementValid = saturate(refinementValid);

    float countersValid =
        finite * nonnegative * partitionValid *
        executedBound * rejectedBound * reusedBound *
        uniqueBound * refinementValid;

    float capability = step(0.5, saturate(capabilityAvailable));
    float authoritySafe = saturate(authority);
    float outputBypassSafe = step(0.5, saturate(outputBypass));
    float workloadBypassSafe = step(0.5, saturate(workloadBypassRequested));
    float numericInvalid = 1.0 - finite * nonnegative;
    float zeroRequest = 1.0 - step(0.5, requested);
    float zeroActive = step(0.5, requested) * (1.0 - step(0.5, active));
    float zeroAuthority = 1.0 - step(CAMERA_OBSCURA_API_WORKLOAD_EPSILON, authoritySafe);

    float effectiveBypass = saturate(max(
        workloadBypassSafe,
        max(
            1.0 - capability,
            max(
                zeroAuthority,
                max(
                    zeroRequest,
                    max(zeroActive, max(1.0 - countersValid, numericInvalid)))))));

    float actualExecuted = declaredExecuted;
    float actualRejected = declaredRejected;
    float actualRefined = declaredRefined;
    float actualReused = declaredReused;
    float actualUnique = declaredUnique;

    if (effectiveBypass > 0.5)
    {
        actualExecuted = 0.0;
        actualRejected = active;
        actualRefined = 0.0;
        actualReused = 0.0;
        actualUnique = 0.0;
    }

    float reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_ACTIVE;
    if (numericInvalid > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_NUMERIC_INVALID;
    }
    else if (zeroRequest > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_REQUEST;
    }
    else if (zeroActive > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_ACTIVE;
    }
    else if (capability < 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_CAPABILITY_UNAVAILABLE;
    }
    else if (zeroAuthority > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_AUTHORITY;
    }
    else if (countersValid < 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_COUNTER_INVALID;
    }
    else if (workloadBypassSafe > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_WORKLOAD_BYPASS;
    }
    else if (outputBypassSafe > 0.5)
    {
        reason = CAMERA_OBSCURA_API_WORKLOAD_REASON_OUTPUT_ONLY_BYPASS;
    }

    workload.requested_units = requested;
    workload.policy_capped_units = policyCap;
    workload.hard_capped_units = hardCap;
    workload.capped_units = capped;
    workload.active_units = active;
    workload.unique_units = actualUnique;
    workload.executed_units = actualExecuted;
    workload.rejected_units = actualRejected;
    workload.refined_units = actualRefined;
    workload.reused_units = actualReused;
    workload.duplicate_units = max(actualExecuted - actualUnique, 0.0);
    workload.physical_units = actualExecuted + actualRefined;
    workload.capability_available = capability;
    workload.authority = authoritySafe;
    workload.output_bypass = outputBypassSafe;
    workload.workload_bypass_requested = workloadBypassSafe;
    workload.workload_bypass_effective = effectiveBypass;
    workload.work_allowed = 1.0 - effectiveBypass;
    workload.counters_valid = countersValid;
    workload.reason = reason;
    return workload;
}

CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_BuildWorkloadSynthetic(float syntheticMode)
{
    CAMERA_OBSCURA_API_Workload workload = CAMERA_OBSCURA_API_MakeWorkload();

    if (syntheticMode < 0.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            8.0, 6.0, 4.0, 4.0, 4.0, 4.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 1.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 2.0, 2.0, 0.0, 0.0, 2.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 2.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 2.0, 2.0, 2.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 3.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 0.0, 2.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 4.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 2.0, 4.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 5.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 1.0, 0.0);
    }
    else if (syntheticMode < 6.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 1.0, 1.0);
    }
    else if (syntheticMode < 7.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 8.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 0.0, 0.0, 0.0,
            1.0, 0.0, 0.0, 0.0);
    }
    else if (syntheticMode < 9.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else if (syntheticMode < 10.5)
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 4.0, 4.0, 2.0, 2.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }
    else
    {
        workload = CAMERA_OBSCURA_API_BuildWorkload(
            4.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            1.0, 1.0, 0.0, 0.0);
    }

    return workload;
}

float3 CAMERA_OBSCURA_API_WorkloadReasonColor(float reason)
{
    float3 color = float3(0.0, 0.0, 0.0);
    if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_ACTIVE)
        color = float3(0.10, 0.90, 0.20);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_OUTPUT_ONLY_BYPASS)
        color = float3(1.00, 0.85, 0.05);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_WORKLOAD_BYPASS)
        color = float3(0.65, 0.10, 1.00);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_CAPABILITY_UNAVAILABLE)
        color = float3(0.10, 0.35, 1.00);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_AUTHORITY)
        color = float3(0.00, 0.90, 0.90);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_REQUEST)
        color = float3(0.40, 0.40, 0.40);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_ACTIVE)
        color = float3(1.00, 0.50, 0.00);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_COUNTER_INVALID)
        color = float3(1.00, 0.05, 0.75);
    else if (reason == CAMERA_OBSCURA_API_WORKLOAD_REASON_NUMERIC_INVALID)
        color = float3(1.00, 0.00, 0.00);
    return color;
}

#endif
