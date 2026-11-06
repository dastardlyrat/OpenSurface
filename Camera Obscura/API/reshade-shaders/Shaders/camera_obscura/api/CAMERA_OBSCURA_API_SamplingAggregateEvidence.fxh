// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_SAMPLING_AGGREGATE_EVIDENCE_FXH
#define CAMERA_OBSCURA_API_SAMPLING_AGGREGATE_EVIDENCE_FXH

#include "CAMERA_OBSCURA_API_Common.fxh"

#define CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_CENTER_FALLBACK 0.0
#define CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_FULL_SUPPORT 1.0
#define CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_PARTIAL_SUPPORT 2.0
#define CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_EMPTY_FALLBACK 3.0
#define CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_INVALID 4.0

// CO-MIG-010 observes aggregate values produced by an existing sampling and
// statistics stage. It performs no texture access, tap generation, loop,
// reduction pass, or reconstruction. The record keeps accounting, support,
// numerical bounds, fallback, outcome, and provenance independently visible.
struct CAMERA_OBSCURA_API_SamplingAggregateEvidence
{
    float valid;

    float requested_taps;
    float active_taps;
    float attempted_taps;
    float accepted_taps;
    float rejected_taps;
    float counts_nonnegative;
    float counts_integral;
    float active_within_request;
    float attempts_within_active;
    float partition_consistent;
    float count_accounting_consistent;

    float zero_attempt;
    float full_support;
    float partial_support;
    float empty_support;
    float support_ratio;
    float rejection_ratio;

    float weight_sum;
    float gate_sum;
    float weight_available;
    float gate_available;
    float weight_support_consistent;
    float gate_support_consistent;

    float center_luma;
    float weighted_luma_mean;
    float luma_min;
    float luma_max;
    float luma_range;
    float luma_variance;
    float variance_upper_bound;
    float max_center_delta;
    float luma_bounds_consistent;
    float mean_in_range;
    float variance_consistent;
    float delta_consistent;
    float statistics_consistent;

    float fallback_expected;
    float fallback_used;
    float fallback_binary;
    float fallback_statistics_consistent;
    float fallback_consistent;

    float aggregate_consistent;

    float request_stamp;
    float neighborhood_stamp;
    float sampling_stamp;
    float statistics_stamp;
    float decision_stamp;
    float generation_stamp;
    float source_stage_stamp;
};

float CAMERA_OBSCURA_API_SamplingAggregateNear(
    float leftValue,
    float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_SamplingAggregateLessEqual(
    float value,
    float upperBound)
{
    return 1.0 - step(0.0001, value - upperBound);
}

float CAMERA_OBSCURA_API_SamplingAggregateUnitRange(float value)
{
    float lowerPass = step(-0.0001, value);
    float upperPass = CAMERA_OBSCURA_API_SamplingAggregateLessEqual(value, 1.0);
    return lowerPass * upperPass;
}

float CAMERA_OBSCURA_API_SamplingAggregateWholeCount(float value)
{
    float rounded = floor(value + 0.5);
    return CAMERA_OBSCURA_API_SamplingAggregateNear(value, rounded);
}

CAMERA_OBSCURA_API_SamplingAggregateEvidence
CAMERA_OBSCURA_API_DefaultSamplingAggregateEvidence()
{
    CAMERA_OBSCURA_API_SamplingAggregateEvidence evidence;
    evidence.valid = 0.0;

    evidence.requested_taps = 0.0;
    evidence.active_taps = 0.0;
    evidence.attempted_taps = 0.0;
    evidence.accepted_taps = 0.0;
    evidence.rejected_taps = 0.0;
    evidence.counts_nonnegative = 0.0;
    evidence.counts_integral = 0.0;
    evidence.active_within_request = 0.0;
    evidence.attempts_within_active = 0.0;
    evidence.partition_consistent = 0.0;
    evidence.count_accounting_consistent = 0.0;

    evidence.zero_attempt = 1.0;
    evidence.full_support = 0.0;
    evidence.partial_support = 0.0;
    evidence.empty_support = 0.0;
    evidence.support_ratio = 0.0;
    evidence.rejection_ratio = 0.0;

    evidence.weight_sum = 0.0;
    evidence.gate_sum = 0.0;
    evidence.weight_available = 0.0;
    evidence.gate_available = 0.0;
    evidence.weight_support_consistent = 0.0;
    evidence.gate_support_consistent = 0.0;

    evidence.center_luma = 0.0;
    evidence.weighted_luma_mean = 0.0;
    evidence.luma_min = 0.0;
    evidence.luma_max = 0.0;
    evidence.luma_range = 0.0;
    evidence.luma_variance = 0.0;
    evidence.variance_upper_bound = 0.0;
    evidence.max_center_delta = 0.0;
    evidence.luma_bounds_consistent = 0.0;
    evidence.mean_in_range = 0.0;
    evidence.variance_consistent = 0.0;
    evidence.delta_consistent = 0.0;
    evidence.statistics_consistent = 0.0;

    evidence.fallback_expected = 1.0;
    evidence.fallback_used = 0.0;
    evidence.fallback_binary = 0.0;
    evidence.fallback_statistics_consistent = 0.0;
    evidence.fallback_consistent = 0.0;

    evidence.aggregate_consistent = 0.0;

    evidence.request_stamp = 0.0;
    evidence.neighborhood_stamp = 0.0;
    evidence.sampling_stamp = 0.0;
    evidence.statistics_stamp = 0.0;
    evidence.decision_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
    return evidence;
}

CAMERA_OBSCURA_API_SamplingAggregateEvidence
CAMERA_OBSCURA_API_BuildSamplingAggregateEvidence(
    float requestedTaps,
    float activeTaps,
    float attemptedTaps,
    float acceptedTaps,
    float rejectedTaps,
    float weightSum,
    float gateSum,
    float centerLuma,
    float weightedLumaMean,
    float lumaMinimum,
    float lumaMaximum,
    float lumaVariance,
    float maxCenterDelta,
    float fallbackUsed,
    float evidenceValid,
    float requestStamp,
    float neighborhoodStamp,
    float samplingStamp,
    float statisticsStamp,
    float decisionStamp,
    float generationStamp,
    float sourceStageStamp)
{
    CAMERA_OBSCURA_API_SamplingAggregateEvidence evidence =
        CAMERA_OBSCURA_API_DefaultSamplingAggregateEvidence();

    float countMinimum = min(
        min(requestedTaps, activeTaps),
        min(attemptedTaps, min(acceptedTaps, rejectedTaps)));
    float countsNonnegative = step(-0.0001, countMinimum);
    float countsIntegral =
        CAMERA_OBSCURA_API_SamplingAggregateWholeCount(requestedTaps) *
        CAMERA_OBSCURA_API_SamplingAggregateWholeCount(activeTaps) *
        CAMERA_OBSCURA_API_SamplingAggregateWholeCount(attemptedTaps) *
        CAMERA_OBSCURA_API_SamplingAggregateWholeCount(acceptedTaps) *
        CAMERA_OBSCURA_API_SamplingAggregateWholeCount(rejectedTaps);
    float activeWithinRequest =
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(activeTaps, requestedTaps);
    float attemptsWithinActive =
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(attemptedTaps, activeTaps);
    float partitionConsistent = CAMERA_OBSCURA_API_SamplingAggregateNear(
        acceptedTaps + rejectedTaps,
        attemptedTaps);
    float countAccountingConsistent =
        countsNonnegative *
        countsIntegral *
        activeWithinRequest *
        attemptsWithinActive *
        partitionConsistent;

    float zeroAttempt = CAMERA_OBSCURA_API_SamplingAggregateNear(attemptedTaps, 0.0);
    float attemptedPositive = step(0.5, attemptedTaps);
    float acceptedPositive = step(0.5, acceptedTaps);
    float rejectedPositive = step(0.5, rejectedTaps);
    float fullSupport =
        attemptedPositive *
        CAMERA_OBSCURA_API_SamplingAggregateNear(acceptedTaps, attemptedTaps);
    float partialSupport = acceptedPositive * rejectedPositive;
    float emptySupport = attemptedPositive * (1.0 - acceptedPositive);
    float safeAttemptCount = max(attemptedTaps, 1.0);
    float supportRatio = saturate(acceptedTaps / safeAttemptCount);
    float rejectionRatio = saturate(rejectedTaps / safeAttemptCount);

    float weightNonnegative = step(-0.0001, weightSum);
    float gateNonnegative = step(-0.0001, gateSum);
    float weightAvailable = step(0.0001, weightSum);
    float gateAvailable = step(0.0001, gateSum);
    float weightSupportConsistent =
        weightNonnegative *
        CAMERA_OBSCURA_API_SamplingAggregateNear(weightAvailable, acceptedPositive);
    float gateSupportConsistent =
        gateNonnegative *
        CAMERA_OBSCURA_API_SamplingAggregateNear(gateAvailable, acceptedPositive) *
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(gateSum, acceptedTaps);

    float lumaRange = max(0.0, lumaMaximum - lumaMinimum);
    float varianceUpperBound = 0.25 * lumaRange * lumaRange;
    float lumaBoundsConsistent =
        CAMERA_OBSCURA_API_SamplingAggregateUnitRange(centerLuma) *
        CAMERA_OBSCURA_API_SamplingAggregateUnitRange(weightedLumaMean) *
        CAMERA_OBSCURA_API_SamplingAggregateUnitRange(lumaMinimum) *
        CAMERA_OBSCURA_API_SamplingAggregateUnitRange(lumaMaximum) *
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(lumaMinimum, lumaMaximum);
    float meanInRange =
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(lumaMinimum, weightedLumaMean) *
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(weightedLumaMean, lumaMaximum);
    float varianceConsistent =
        step(-0.0001, lumaVariance) *
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(
            lumaVariance,
            varianceUpperBound + 0.0001);
    float deltaConsistent =
        step(-0.0001, maxCenterDelta) *
        CAMERA_OBSCURA_API_SamplingAggregateLessEqual(maxCenterDelta, 1.0);
    float statisticsConsistent =
        lumaBoundsConsistent *
        meanInRange *
        varianceConsistent *
        deltaConsistent;

    float fallbackExpected = saturate(max(zeroAttempt, emptySupport));
    float fallbackZero = CAMERA_OBSCURA_API_SamplingAggregateNear(fallbackUsed, 0.0);
    float fallbackOne = CAMERA_OBSCURA_API_SamplingAggregateNear(fallbackUsed, 1.0);
    float fallbackBinary = saturate(fallbackZero + fallbackOne);
    float fallbackStatisticsConsistent =
        CAMERA_OBSCURA_API_SamplingAggregateNear(weightedLumaMean, centerLuma) *
        CAMERA_OBSCURA_API_SamplingAggregateNear(lumaMinimum, centerLuma) *
        CAMERA_OBSCURA_API_SamplingAggregateNear(lumaMaximum, centerLuma) *
        CAMERA_OBSCURA_API_SamplingAggregateNear(lumaVariance, 0.0) *
        CAMERA_OBSCURA_API_SamplingAggregateNear(maxCenterDelta, 0.0);
    float fallbackExpectedPass = fallbackOne * fallbackStatisticsConsistent;
    float fallbackNotExpectedPass = fallbackZero;
    float fallbackConsistent = fallbackBinary * lerp(
        fallbackNotExpectedPass,
        fallbackExpectedPass,
        fallbackExpected);

    float aggregateConsistent =
        saturate(evidenceValid) *
        countAccountingConsistent *
        weightSupportConsistent *
        gateSupportConsistent *
        statisticsConsistent *
        fallbackConsistent;

    evidence.valid = saturate(evidenceValid);

    evidence.requested_taps = requestedTaps;
    evidence.active_taps = activeTaps;
    evidence.attempted_taps = attemptedTaps;
    evidence.accepted_taps = acceptedTaps;
    evidence.rejected_taps = rejectedTaps;
    evidence.counts_nonnegative = countsNonnegative;
    evidence.counts_integral = countsIntegral;
    evidence.active_within_request = activeWithinRequest;
    evidence.attempts_within_active = attemptsWithinActive;
    evidence.partition_consistent = partitionConsistent;
    evidence.count_accounting_consistent = countAccountingConsistent;

    evidence.zero_attempt = zeroAttempt;
    evidence.full_support = fullSupport;
    evidence.partial_support = partialSupport;
    evidence.empty_support = emptySupport;
    evidence.support_ratio = supportRatio;
    evidence.rejection_ratio = rejectionRatio;

    evidence.weight_sum = weightSum;
    evidence.gate_sum = gateSum;
    evidence.weight_available = weightAvailable;
    evidence.gate_available = gateAvailable;
    evidence.weight_support_consistent = weightSupportConsistent;
    evidence.gate_support_consistent = gateSupportConsistent;

    evidence.center_luma = centerLuma;
    evidence.weighted_luma_mean = weightedLumaMean;
    evidence.luma_min = lumaMinimum;
    evidence.luma_max = lumaMaximum;
    evidence.luma_range = lumaRange;
    evidence.luma_variance = lumaVariance;
    evidence.variance_upper_bound = varianceUpperBound;
    evidence.max_center_delta = maxCenterDelta;
    evidence.luma_bounds_consistent = lumaBoundsConsistent;
    evidence.mean_in_range = meanInRange;
    evidence.variance_consistent = varianceConsistent;
    evidence.delta_consistent = deltaConsistent;
    evidence.statistics_consistent = statisticsConsistent;

    evidence.fallback_expected = fallbackExpected;
    evidence.fallback_used = fallbackUsed;
    evidence.fallback_binary = fallbackBinary;
    evidence.fallback_statistics_consistent = fallbackStatisticsConsistent;
    evidence.fallback_consistent = fallbackConsistent;

    evidence.aggregate_consistent = aggregateConsistent;

    evidence.request_stamp = requestStamp;
    evidence.neighborhood_stamp = neighborhoodStamp;
    evidence.sampling_stamp = samplingStamp;
    evidence.statistics_stamp = statisticsStamp;
    evidence.decision_stamp = decisionStamp;
    evidence.generation_stamp = generationStamp;
    evidence.source_stage_stamp = sourceStageStamp;
    return evidence;
}

float CAMERA_OBSCURA_API_SamplingAggregateClass(
    CAMERA_OBSCURA_API_SamplingAggregateEvidence evidence)
{
    float invalid = 1.0 - step(0.5, evidence.aggregate_consistent);
    float centerFallback = evidence.zero_attempt * (1.0 - invalid);
    float emptyFallback = evidence.empty_support * (1.0 - invalid);
    float partialSupport = evidence.partial_support * (1.0 - invalid);
    float aggregateClass = CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_FULL_SUPPORT;
    aggregateClass = lerp(
        aggregateClass,
        CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_PARTIAL_SUPPORT,
        partialSupport);
    aggregateClass = lerp(
        aggregateClass,
        CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_EMPTY_FALLBACK,
        emptyFallback);
    aggregateClass = lerp(
        aggregateClass,
        CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_CENTER_FALLBACK,
        centerFallback);
    aggregateClass = lerp(
        aggregateClass,
        CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_INVALID,
        invalid);
    return aggregateClass;
}

#endif // CAMERA_OBSCURA_API_SAMPLING_AGGREGATE_EVIDENCE_FXH
