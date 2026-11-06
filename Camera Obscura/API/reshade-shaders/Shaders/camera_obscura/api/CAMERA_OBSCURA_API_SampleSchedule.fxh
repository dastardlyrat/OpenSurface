// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_FXH
#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_FXH

#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_SEQUENTIAL 0.0
#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_DISTRIBUTED 1.0

#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_NONE 0.0
#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_COUNT 1.0
#define CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_INDEX 2.0

struct CAMERA_OBSCURA_API_SampleScheduleEvidence
{
    float requested_logical_index;
    float resolved_logical_index;
    float requested_active_count;
    float resolved_active_count;
    float requested_canonical_count;
    float resolved_canonical_count;
    float requested_policy;
    float resolved_policy;
    float reduction_active;
    float resolved_stride;
    float resolved_canonical_index;
    float center_identity;
    float count_clamped;
    float index_clamped;
    float mapping_valid;
    float rejection_reason;
};

CAMERA_OBSCURA_API_SampleScheduleEvidence CAMERA_OBSCURA_API_DefaultSampleScheduleEvidence()
{
    CAMERA_OBSCURA_API_SampleScheduleEvidence evidence;
    evidence.requested_logical_index = 0.0;
    evidence.resolved_logical_index = 0.0;
    evidence.requested_active_count = 0.0;
    evidence.resolved_active_count = 0.0;
    evidence.requested_canonical_count = 0.0;
    evidence.resolved_canonical_count = 0.0;
    evidence.requested_policy = CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_SEQUENTIAL;
    evidence.resolved_policy = CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_SEQUENTIAL;
    evidence.reduction_active = 0.0;
    evidence.resolved_stride = 0.0;
    evidence.resolved_canonical_index = 0.0;
    evidence.center_identity = 0.0;
    evidence.count_clamped = 0.0;
    evidence.index_clamped = 0.0;
    evidence.mapping_valid = 0.0;
    evidence.rejection_reason = CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_COUNT;
    return evidence;
}

CAMERA_OBSCURA_API_SampleScheduleEvidence CAMERA_OBSCURA_API_EvaluateSampleSchedule(
    float requestedLogicalIndex,
    float requestedActiveCount,
    float requestedCanonicalCount,
    float requestedPolicy)
{
    CAMERA_OBSCURA_API_SampleScheduleEvidence evidence = CAMERA_OBSCURA_API_DefaultSampleScheduleEvidence();

    float canonicalInputValid = step(0.5, requestedCanonicalCount);
    float activeInputValid = step(0.5, requestedActiveCount);
    float indexInputValid = step(0.0, requestedLogicalIndex);
    float countsValid = canonicalInputValid * activeInputValid;

    float canonicalCount = max(floor(requestedCanonicalCount + 0.5), 1.0);
    float activeCountRounded = max(floor(requestedActiveCount + 0.5), 1.0);
    float activeCount = min(activeCountRounded, canonicalCount);
    float logicalIndexRounded = floor(max(requestedLogicalIndex, 0.0) + 0.5);
    float logicalIndex = min(logicalIndexRounded, activeCount - 1.0);
    float policy = step(0.5, requestedPolicy);
    float reductionActive = step(activeCount + 0.5, canonicalCount);
    float distributedDenominator = max(activeCount - 1.0, 1.0);
    float distributedStride = (canonicalCount - 1.0) / distributedDenominator;
    float distributedIndex = (logicalIndex < 0.5) ? 0.0 :
        1.0 + floor(((logicalIndex - 1.0) * (canonicalCount - 1.0)) / distributedDenominator + 0.5);
    float sequentialIndex = logicalIndex;
    float resolvedIndex = lerp(sequentialIndex, distributedIndex, policy * reductionActive);
    resolvedIndex = min(max(resolvedIndex, 0.0), canonicalCount - 1.0);

    float countClamped = step(canonicalCount + 0.5, activeCountRounded);
    float indexClamped = step(activeCount - 0.5, logicalIndexRounded);
    float mappingValid = countsValid * indexInputValid;
    float rejectionReason = CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_NONE;
    rejectionReason = (countsValid < 0.5) ? CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_COUNT : rejectionReason;
    rejectionReason = ((countsValid >= 0.5) && (indexInputValid < 0.5)) ? CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_INDEX : rejectionReason;

    evidence.requested_logical_index = requestedLogicalIndex;
    evidence.resolved_logical_index = logicalIndex;
    evidence.requested_active_count = requestedActiveCount;
    evidence.resolved_active_count = activeCount;
    evidence.requested_canonical_count = requestedCanonicalCount;
    evidence.resolved_canonical_count = canonicalCount;
    evidence.requested_policy = requestedPolicy;
    evidence.resolved_policy = policy;
    evidence.reduction_active = reductionActive;
    evidence.resolved_stride = lerp(1.0, distributedStride, policy * reductionActive);
    evidence.resolved_canonical_index = resolvedIndex;
    evidence.center_identity = 1.0 - step(0.5, logicalIndex);
    evidence.count_clamped = countClamped;
    evidence.index_clamped = indexClamped;
    evidence.mapping_valid = mappingValid;
    evidence.rejection_reason = rejectionReason;
    return evidence;
}

#endif
