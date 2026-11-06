// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_PROVIDER_IDENTITY_FXH
#define CAMERA_OBSCURA_API_PROVIDER_IDENTITY_FXH

#include "../header/CAMERA_OBSCURA_AtomicCommon.fxh"

#define CAMERA_OBSCURA_API_PROVIDER_IDENTITY_VERSION 1

#define CAMERA_OBSCURA_API_PROVIDER_SOURCE_NONE 0
#define CAMERA_OBSCURA_API_PROVIDER_SOURCE_LIVE 1
#define CAMERA_OBSCURA_API_PROVIDER_SOURCE_CACHE 2

#define CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY 0
#define CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE 1
#define CAMERA_OBSCURA_API_CACHE_MODE_CACHE_ONLY 2
#define CAMERA_OBSCURA_API_CACHE_MODE_PREFER_LIVE 3

#define CAMERA_OBSCURA_API_FALLBACK_NONE 0
#define CAMERA_OBSCURA_API_FALLBACK_LIVE 1
#define CAMERA_OBSCURA_API_FALLBACK_CACHE 2
#define CAMERA_OBSCURA_API_FALLBACK_SOURCE_PASSTHROUGH 3

#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_UNINITIALIZED 0
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY 1
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY_ZERO_FILLED 2
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_ABSENT 3
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_CAPABILITY_UNAVAILABLE 4
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_VALUE_INVALID 5
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_PRODUCER_MISMATCH 6
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_POLICY_MISMATCH 7
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_GENERATION_STALE 8
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_SOURCE_STAGE_MISMATCH 9
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_RESOLUTION_MISMATCH 10
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_METRIC_MISMATCH 11
#define CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_NUMERIC_INVALID 12

#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_UNINITIALIZED 20
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_SELECTED 21
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_SELECTED 22
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_LIVE 23
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_CACHE 24
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_ONLY_UNAVAILABLE 25
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_ONLY_UNAVAILABLE 26
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_NO_READY_SOURCE 27
#define CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_MODE_INVALID 28

#ifndef CAMERA_OBSCURA_API_PROVIDER_IDENTITY_EPSILON
#define CAMERA_OBSCURA_API_PROVIDER_IDENTITY_EPSILON 0.000001
#endif

struct CAMERA_OBSCURA_API_ProviderDescriptor
{
    float record_present;
    float capability_available;
    float producer_id;
    float policy_id;
    float generation;
    float source_stage_id;
    float resolution_id;
    float metric_id;
    float value_valid;
    float zero_filled;
};

struct CAMERA_OBSCURA_API_ProviderDecision
{
    float cache_mode;
    float cache_mode_valid;

    float live_present;
    float live_capability;
    float live_value_valid;
    float live_zero_filled;
    float live_numeric_valid;
    float live_producer_match;
    float live_policy_match;
    float live_generation_match;
    float live_source_stage_match;
    float live_resolution_match;
    float live_metric_match;
    float live_identity_valid;
    float live_ready;
    float live_reason;

    float cache_present;
    float cache_capability;
    float cache_value_valid;
    float cache_zero_filled;
    float cache_numeric_valid;
    float cache_producer_match;
    float cache_policy_match;
    float cache_generation_match;
    float cache_source_stage_match;
    float cache_resolution_match;
    float cache_metric_match;
    float cache_identity_valid;
    float cache_ready;
    float cache_stale;
    float cache_reason;

    float selected_source;
    float selected_producer_id;
    float selected_policy_id;
    float selected_generation;
    float selected_source_stage_id;
    float selected_resolution_id;
    float selected_metric_id;
    float fallback_disposition;
    float fallback_used;
    float ready;
    float reason;
};

CAMERA_OBSCURA_API_ProviderDescriptor CAMERA_OBSCURA_API_MakeProviderDescriptor()
{
    CAMERA_OBSCURA_API_ProviderDescriptor descriptor;
    descriptor.record_present = 0.0;
    descriptor.capability_available = 0.0;
    descriptor.producer_id = 0.0;
    descriptor.policy_id = 0.0;
    descriptor.generation = 0.0;
    descriptor.source_stage_id = 0.0;
    descriptor.resolution_id = 0.0;
    descriptor.metric_id = 0.0;
    descriptor.value_valid = 0.0;
    descriptor.zero_filled = 0.0;
    return descriptor;
}

CAMERA_OBSCURA_API_ProviderDescriptor CAMERA_OBSCURA_API_BuildProviderDescriptor(
    float recordPresent,
    float capabilityAvailable,
    float producerId,
    float policyId,
    float generationId,
    float sourceStageId,
    float resolutionId,
    float metricId,
    float valueValid,
    float zeroFilled)
{
    CAMERA_OBSCURA_API_ProviderDescriptor descriptor = CAMERA_OBSCURA_API_MakeProviderDescriptor();
    descriptor.record_present = step(0.5, saturate(recordPresent));
    descriptor.capability_available = step(0.5, saturate(capabilityAvailable));
    descriptor.producer_id = producerId;
    descriptor.policy_id = policyId;
    descriptor.generation = generationId;
    descriptor.source_stage_id = sourceStageId;
    descriptor.resolution_id = resolutionId;
    descriptor.metric_id = metricId;
    descriptor.value_valid = step(0.5, saturate(valueValid));
    descriptor.zero_filled = step(0.5, saturate(zeroFilled));
    return descriptor;
}

CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_MakeProviderDecision()
{
    CAMERA_OBSCURA_API_ProviderDecision decision;
    decision.cache_mode = CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY;
    decision.cache_mode_valid = 0.0;

    decision.live_present = 0.0;
    decision.live_capability = 0.0;
    decision.live_value_valid = 0.0;
    decision.live_zero_filled = 0.0;
    decision.live_numeric_valid = 0.0;
    decision.live_producer_match = 0.0;
    decision.live_policy_match = 0.0;
    decision.live_generation_match = 0.0;
    decision.live_source_stage_match = 0.0;
    decision.live_resolution_match = 0.0;
    decision.live_metric_match = 0.0;
    decision.live_identity_valid = 0.0;
    decision.live_ready = 0.0;
    decision.live_reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_UNINITIALIZED;

    decision.cache_present = 0.0;
    decision.cache_capability = 0.0;
    decision.cache_value_valid = 0.0;
    decision.cache_zero_filled = 0.0;
    decision.cache_numeric_valid = 0.0;
    decision.cache_producer_match = 0.0;
    decision.cache_policy_match = 0.0;
    decision.cache_generation_match = 0.0;
    decision.cache_source_stage_match = 0.0;
    decision.cache_resolution_match = 0.0;
    decision.cache_metric_match = 0.0;
    decision.cache_identity_valid = 0.0;
    decision.cache_ready = 0.0;
    decision.cache_stale = 0.0;
    decision.cache_reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_UNINITIALIZED;

    decision.selected_source = CAMERA_OBSCURA_API_PROVIDER_SOURCE_NONE;
    decision.selected_producer_id = 0.0;
    decision.selected_policy_id = 0.0;
    decision.selected_generation = 0.0;
    decision.selected_source_stage_id = 0.0;
    decision.selected_resolution_id = 0.0;
    decision.selected_metric_id = 0.0;
    decision.fallback_disposition = CAMERA_OBSCURA_API_FALLBACK_SOURCE_PASSTHROUGH;
    decision.fallback_used = 0.0;
    decision.ready = 0.0;
    decision.reason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_UNINITIALIZED;
    return decision;
}

float CAMERA_OBSCURA_API_ProviderIdentityFinite(float value)
{
    return ((value == value) && (abs(value) < 1.0e19)) ? 1.0 : 0.0;
}

float CAMERA_OBSCURA_API_ProviderIdentityApprox(float value, float expected)
{
    return 1.0 - step(
        CAMERA_OBSCURA_API_PROVIDER_IDENTITY_EPSILON,
        abs(value - expected));
}

float CAMERA_OBSCURA_API_ProviderIdentityInteger(float value)
{
    float nearest = floor(value + 0.5);
    return
        CAMERA_OBSCURA_API_ProviderIdentityFinite(value) *
        step(0.0, value) *
        CAMERA_OBSCURA_API_ProviderIdentityApprox(value, nearest);
}

float CAMERA_OBSCURA_API_ProviderDescriptorNumericValid(
    CAMERA_OBSCURA_API_ProviderDescriptor descriptor)
{
    return
        CAMERA_OBSCURA_API_ProviderIdentityFinite(descriptor.record_present) *
        CAMERA_OBSCURA_API_ProviderIdentityFinite(descriptor.capability_available) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.producer_id) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.policy_id) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.generation) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.source_stage_id) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.resolution_id) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(descriptor.metric_id) *
        CAMERA_OBSCURA_API_ProviderIdentityFinite(descriptor.value_valid) *
        CAMERA_OBSCURA_API_ProviderIdentityFinite(descriptor.zero_filled);
}

float CAMERA_OBSCURA_API_ProviderCandidateReason(
    float numericValid,
    float present,
    float capability,
    float valueValid,
    float producerMatch,
    float policyMatch,
    float generationMatch,
    float sourceStageMatch,
    float resolutionMatch,
    float metricMatch,
    float zeroFilled)
{
    float reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY;
    if (numericValid < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_NUMERIC_INVALID;
    else if (present < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_ABSENT;
    else if (capability < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_CAPABILITY_UNAVAILABLE;
    else if (valueValid < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_VALUE_INVALID;
    else if (producerMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_PRODUCER_MISMATCH;
    else if (policyMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_POLICY_MISMATCH;
    else if (generationMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_GENERATION_STALE;
    else if (sourceStageMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_SOURCE_STAGE_MISMATCH;
    else if (resolutionMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_RESOLUTION_MISMATCH;
    else if (metricMatch < 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_METRIC_MISMATCH;
    else if (zeroFilled > 0.5)
        reason = CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY_ZERO_FILLED;
    return reason;
}

CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_BuildProviderDecision(
    float expectedProducerId,
    float expectedPolicyId,
    float expectedGeneration,
    float expectedSourceStageId,
    float expectedResolutionId,
    float expectedMetricId,
    float cacheMode,
    CAMERA_OBSCURA_API_ProviderDescriptor liveDescriptor,
    CAMERA_OBSCURA_API_ProviderDescriptor cacheDescriptor)
{
    CAMERA_OBSCURA_API_ProviderDecision decision = CAMERA_OBSCURA_API_MakeProviderDecision();

    float expectedNumericValid =
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedProducerId) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedPolicyId) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedGeneration) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedSourceStageId) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedResolutionId) *
        CAMERA_OBSCURA_API_ProviderIdentityInteger(expectedMetricId);

    float liveNumericValid =
        expectedNumericValid *
        CAMERA_OBSCURA_API_ProviderDescriptorNumericValid(liveDescriptor);
    float cacheNumericValid =
        expectedNumericValid *
        CAMERA_OBSCURA_API_ProviderDescriptorNumericValid(cacheDescriptor);

    float liveProducerMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.producer_id, expectedProducerId);
    float livePolicyMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.policy_id, expectedPolicyId);
    float liveGenerationMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.generation, expectedGeneration);
    float liveSourceStageMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.source_stage_id, expectedSourceStageId);
    float liveResolutionMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.resolution_id, expectedResolutionId);
    float liveMetricMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(liveDescriptor.metric_id, expectedMetricId);
    float liveIdentityValid =
        liveNumericValid * liveProducerMatch * livePolicyMatch *
        liveGenerationMatch * liveSourceStageMatch *
        liveResolutionMatch * liveMetricMatch;
    float liveReady =
        liveDescriptor.record_present *
        liveDescriptor.capability_available *
        liveDescriptor.value_valid *
        liveIdentityValid;

    float cacheProducerMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.producer_id, expectedProducerId);
    float cachePolicyMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.policy_id, expectedPolicyId);
    float cacheGenerationMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.generation, expectedGeneration);
    float cacheSourceStageMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.source_stage_id, expectedSourceStageId);
    float cacheResolutionMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.resolution_id, expectedResolutionId);
    float cacheMetricMatch = CAMERA_OBSCURA_API_ProviderIdentityApprox(cacheDescriptor.metric_id, expectedMetricId);
    float cacheIdentityValid =
        cacheNumericValid * cacheProducerMatch * cachePolicyMatch *
        cacheGenerationMatch * cacheSourceStageMatch *
        cacheResolutionMatch * cacheMetricMatch;
    float cacheReady =
        cacheDescriptor.record_present *
        cacheDescriptor.capability_available *
        cacheDescriptor.value_valid *
        cacheIdentityValid;

    float cacheModeRounded = floor(cacheMode + 0.5);
    float cacheModeInteger = CAMERA_OBSCURA_API_ProviderIdentityInteger(cacheMode);
    float cacheModeInRange = step(0.0, cacheModeRounded) * step(cacheModeRounded, 3.0);
    float cacheModeValid = cacheModeInteger * cacheModeInRange;

    decision.cache_mode = cacheModeRounded;
    decision.cache_mode_valid = cacheModeValid;

    decision.live_present = liveDescriptor.record_present;
    decision.live_capability = liveDescriptor.capability_available;
    decision.live_value_valid = liveDescriptor.value_valid;
    decision.live_zero_filled = liveDescriptor.zero_filled;
    decision.live_numeric_valid = liveNumericValid;
    decision.live_producer_match = liveProducerMatch;
    decision.live_policy_match = livePolicyMatch;
    decision.live_generation_match = liveGenerationMatch;
    decision.live_source_stage_match = liveSourceStageMatch;
    decision.live_resolution_match = liveResolutionMatch;
    decision.live_metric_match = liveMetricMatch;
    decision.live_identity_valid = liveIdentityValid;
    decision.live_ready = liveReady;
    decision.live_reason = CAMERA_OBSCURA_API_ProviderCandidateReason(
        liveNumericValid,
        liveDescriptor.record_present,
        liveDescriptor.capability_available,
        liveDescriptor.value_valid,
        liveProducerMatch,
        livePolicyMatch,
        liveGenerationMatch,
        liveSourceStageMatch,
        liveResolutionMatch,
        liveMetricMatch,
        liveDescriptor.zero_filled);

    decision.cache_present = cacheDescriptor.record_present;
    decision.cache_capability = cacheDescriptor.capability_available;
    decision.cache_value_valid = cacheDescriptor.value_valid;
    decision.cache_zero_filled = cacheDescriptor.zero_filled;
    decision.cache_numeric_valid = cacheNumericValid;
    decision.cache_producer_match = cacheProducerMatch;
    decision.cache_policy_match = cachePolicyMatch;
    decision.cache_generation_match = cacheGenerationMatch;
    decision.cache_source_stage_match = cacheSourceStageMatch;
    decision.cache_resolution_match = cacheResolutionMatch;
    decision.cache_metric_match = cacheMetricMatch;
    decision.cache_identity_valid = cacheIdentityValid;
    decision.cache_ready = cacheReady;
    decision.cache_stale =
        cacheNumericValid * cacheDescriptor.record_present *
        (1.0 - cacheGenerationMatch);
    decision.cache_reason = CAMERA_OBSCURA_API_ProviderCandidateReason(
        cacheNumericValid,
        cacheDescriptor.record_present,
        cacheDescriptor.capability_available,
        cacheDescriptor.value_valid,
        cacheProducerMatch,
        cachePolicyMatch,
        cacheGenerationMatch,
        cacheSourceStageMatch,
        cacheResolutionMatch,
        cacheMetricMatch,
        cacheDescriptor.zero_filled);

    float selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_NONE;
    float fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_SOURCE_PASSTHROUGH;
    float fallbackUsed = 0.0;
    float decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_NO_READY_SOURCE;

    if (cacheModeValid < 0.5)
    {
        decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_MODE_INVALID;
    }
    else if (cacheModeRounded < 0.5)
    {
        if (liveReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_LIVE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_NONE;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_SELECTED;
        }
        else
        {
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_ONLY_UNAVAILABLE;
        }
    }
    else if (cacheModeRounded < 1.5)
    {
        if (cacheReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_CACHE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_NONE;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_SELECTED;
        }
        else if (liveReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_LIVE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_LIVE;
            fallbackUsed = 1.0;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_LIVE;
        }
    }
    else if (cacheModeRounded < 2.5)
    {
        if (cacheReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_CACHE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_NONE;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_SELECTED;
        }
        else
        {
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_ONLY_UNAVAILABLE;
        }
    }
    else
    {
        if (liveReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_LIVE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_NONE;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_SELECTED;
        }
        else if (cacheReady > 0.5)
        {
            selectedSource = CAMERA_OBSCURA_API_PROVIDER_SOURCE_CACHE;
            fallbackDisposition = CAMERA_OBSCURA_API_FALLBACK_CACHE;
            fallbackUsed = 1.0;
            decisionReason = CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_CACHE;
        }
    }

    decision.selected_source = selectedSource;
    decision.fallback_disposition = fallbackDisposition;
    decision.fallback_used = fallbackUsed;
    decision.ready = step(0.5, selectedSource);
    decision.reason = decisionReason;

    if (selectedSource < 1.5 && selectedSource > 0.5)
    {
        decision.selected_producer_id = liveDescriptor.producer_id;
        decision.selected_policy_id = liveDescriptor.policy_id;
        decision.selected_generation = liveDescriptor.generation;
        decision.selected_source_stage_id = liveDescriptor.source_stage_id;
        decision.selected_resolution_id = liveDescriptor.resolution_id;
        decision.selected_metric_id = liveDescriptor.metric_id;
    }
    else if (selectedSource > 1.5)
    {
        decision.selected_producer_id = cacheDescriptor.producer_id;
        decision.selected_policy_id = cacheDescriptor.policy_id;
        decision.selected_generation = cacheDescriptor.generation;
        decision.selected_source_stage_id = cacheDescriptor.source_stage_id;
        decision.selected_resolution_id = cacheDescriptor.resolution_id;
        decision.selected_metric_id = cacheDescriptor.metric_id;
    }

    return decision;
}

CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_BuildProviderDecisionSynthetic(float syntheticMode)
{
    float expectedProducer = 101.0;
    float expectedPolicy = 201.0;
    float expectedGeneration = 7.0;
    float expectedStage = 301.0;
    float expectedResolution = 1440.0;
    float expectedMetric = 1.0;
    float cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY;

    CAMERA_OBSCURA_API_ProviderDescriptor liveDescriptor = CAMERA_OBSCURA_API_BuildProviderDescriptor(
        1.0, 1.0,
        expectedProducer, expectedPolicy, expectedGeneration,
        expectedStage, expectedResolution, expectedMetric,
        1.0, 0.0);
    CAMERA_OBSCURA_API_ProviderDescriptor cacheDescriptor = CAMERA_OBSCURA_API_BuildProviderDescriptor(
        1.0, 1.0,
        expectedProducer, expectedPolicy, expectedGeneration,
        expectedStage, expectedResolution, expectedMetric,
        1.0, 0.0);

    if (syntheticMode < 0.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY;
    }
    else if (syntheticMode < 1.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_CACHE_ONLY;
    }
    else if (syntheticMode < 2.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
    }
    else if (syntheticMode < 3.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_LIVE;
    }
    else if (syntheticMode < 4.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.record_present = 0.0;
    }
    else if (syntheticMode < 5.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.zero_filled = 1.0;
    }
    else if (syntheticMode < 6.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.generation = expectedGeneration - 1.0;
    }
    else if (syntheticMode < 7.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.policy_id = expectedPolicy + 1.0;
    }
    else if (syntheticMode < 8.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.resolution_id = 1080.0;
    }
    else if (syntheticMode < 9.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.producer_id = expectedProducer + 1.0;
    }
    else if (syntheticMode < 10.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.source_stage_id = expectedStage + 1.0;
    }
    else if (syntheticMode < 11.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.metric_id = expectedMetric + 1.0;
    }
    else if (syntheticMode < 12.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_LIVE;
        liveDescriptor.record_present = 0.0;
    }
    else if (syntheticMode < 13.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_CACHE_ONLY;
        cacheDescriptor.generation = expectedGeneration - 1.0;
    }
    else if (syntheticMode < 14.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY;
        liveDescriptor.record_present = 0.0;
    }
    else if (syntheticMode < 15.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        liveDescriptor.record_present = 0.0;
        cacheDescriptor.record_present = 0.0;
    }
    else if (syntheticMode < 16.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.capability_available = 0.0;
    }
    else if (syntheticMode < 17.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.value_valid = 0.0;
    }
    else if (syntheticMode < 18.5)
    {
        cacheMode = CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE;
        cacheDescriptor.producer_id = 1.0e20;
    }
    else
    {
        cacheMode = 9.0;
    }

    return CAMERA_OBSCURA_API_BuildProviderDecision(
        expectedProducer,
        expectedPolicy,
        expectedGeneration,
        expectedStage,
        expectedResolution,
        expectedMetric,
        cacheMode,
        liveDescriptor,
        cacheDescriptor);
}

#endif // CAMERA_OBSCURA_API_PROVIDER_IDENTITY_FXH
