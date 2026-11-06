// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_DEPTH_GATE_EVIDENCE_FXH
#define CAMERA_OBSCURA_API_DEPTH_GATE_EVIDENCE_FXH

#include "CAMERA_OBSCURA_API_Common.fxh"

#define CAMERA_OBSCURA_API_DEPTH_GATE_NONE 0.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_HARD 1.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_SOFT 2.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_FAR_ONLY 3.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_NEAR_SUPPRESS 4.0

#define CAMERA_OBSCURA_API_DEPTH_MISSING_REJECT 0.0
#define CAMERA_OBSCURA_API_DEPTH_MISSING_PASS 1.0

#define CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BYPASS 0.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BINARY 1.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_WEIGHTED 2.0
#define CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_INVALID 3.0

// CO-MIG-009 records a depth-gate decision without sampling depth or wiring a
// runtime gate. Inputs are explicit scalar evidence. The expected gate remains
// separate from the observed/applied gate so later consumers cannot hide policy
// selection, missing-depth handling, or weighting behind one opaque value.
struct CAMERA_OBSCURA_API_DepthGateEvidence
{
    float valid;

    float gate_mode;
    float gate_mode_recognized;
    float depth_missing_mode;
    float depth_missing_mode_recognized;

    float center_depth;
    float sample_depth;
    float depth_available;
    float depth_missing;
    float depth_delta;

    float reject_threshold;
    float reject_softness;
    float far_start;
    float far_feather;
    float near_end;
    float near_feather;
    float parameters_adjusted;

    float missing_fallback_weight;
    float same_layer_hard_weight;
    float same_layer_soft_weight;
    float far_mask;
    float near_mask;

    float route_none;
    float route_hard;
    float route_soft;
    float route_far;
    float route_near;
    float route_missing;

    float expected_gate_weight;
    float observed_gate_weight;
    float observed_consistent;
    float full_pass;
    float full_reject;
    float partial_weight;
    float gate_consistent;

    float request_stamp;
    float surface_stamp;
    float sample_stamp;
    float policy_stamp;
    float gate_stamp;
    float generation_stamp;
    float source_stage_stamp;
};

float CAMERA_OBSCURA_API_DepthGateValueNear(
    float leftValue,
    float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_DepthGateSmoothRange(
    float rangeStart,
    float rangeWidth,
    float value)
{
    float safeWidth = max(rangeWidth, 0.000001);
    float normalized = saturate((value - rangeStart) / safeWidth);
    return normalized * normalized * (3.0 - 2.0 * normalized);
}

CAMERA_OBSCURA_API_DepthGateEvidence
CAMERA_OBSCURA_API_DefaultDepthGateEvidence()
{
    CAMERA_OBSCURA_API_DepthGateEvidence evidence;
    evidence.valid = 0.0;

    evidence.gate_mode = CAMERA_OBSCURA_API_DEPTH_GATE_NONE;
    evidence.gate_mode_recognized = 0.0;
    evidence.depth_missing_mode = CAMERA_OBSCURA_API_DEPTH_MISSING_REJECT;
    evidence.depth_missing_mode_recognized = 0.0;

    evidence.center_depth = 0.0;
    evidence.sample_depth = 0.0;
    evidence.depth_available = 0.0;
    evidence.depth_missing = 1.0;
    evidence.depth_delta = 0.0;

    evidence.reject_threshold = 0.000001;
    evidence.reject_softness = 0.000001;
    evidence.far_start = 0.0;
    evidence.far_feather = 0.000001;
    evidence.near_end = 0.0;
    evidence.near_feather = 0.000001;
    evidence.parameters_adjusted = 0.0;

    evidence.missing_fallback_weight = 0.0;
    evidence.same_layer_hard_weight = 0.0;
    evidence.same_layer_soft_weight = 0.0;
    evidence.far_mask = 0.0;
    evidence.near_mask = 0.0;

    evidence.route_none = 0.0;
    evidence.route_hard = 0.0;
    evidence.route_soft = 0.0;
    evidence.route_far = 0.0;
    evidence.route_near = 0.0;
    evidence.route_missing = 0.0;

    evidence.expected_gate_weight = 1.0;
    evidence.observed_gate_weight = 1.0;
    evidence.observed_consistent = 0.0;
    evidence.full_pass = 1.0;
    evidence.full_reject = 0.0;
    evidence.partial_weight = 0.0;
    evidence.gate_consistent = 0.0;

    evidence.request_stamp = 0.0;
    evidence.surface_stamp = 0.0;
    evidence.sample_stamp = 0.0;
    evidence.policy_stamp = 0.0;
    evidence.gate_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
    return evidence;
}

CAMERA_OBSCURA_API_DepthGateEvidence
CAMERA_OBSCURA_API_BuildDepthGateEvidence(
    float gateMode,
    float centerDepth,
    float sampleDepth,
    float depthAvailable,
    float rejectThreshold,
    float rejectSoftness,
    float farStart,
    float farFeather,
    float nearEnd,
    float nearFeather,
    float depthMissingMode,
    float observedGateWeight,
    float evidenceValid,
    float requestStamp,
    float surfaceStamp,
    float sampleStamp,
    float policyStamp,
    float gateStamp,
    float generationStamp,
    float sourceStageStamp)
{
    CAMERA_OBSCURA_API_DepthGateEvidence evidence =
        CAMERA_OBSCURA_API_DefaultDepthGateEvidence();

    float modeNone = CAMERA_OBSCURA_API_DepthGateValueNear(
        gateMode,
        CAMERA_OBSCURA_API_DEPTH_GATE_NONE);
    float modeHard = CAMERA_OBSCURA_API_DepthGateValueNear(
        gateMode,
        CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_HARD);
    float modeSoft = CAMERA_OBSCURA_API_DepthGateValueNear(
        gateMode,
        CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_SOFT);
    float modeFar = CAMERA_OBSCURA_API_DepthGateValueNear(
        gateMode,
        CAMERA_OBSCURA_API_DEPTH_GATE_FAR_ONLY);
    float modeNear = CAMERA_OBSCURA_API_DepthGateValueNear(
        gateMode,
        CAMERA_OBSCURA_API_DEPTH_GATE_NEAR_SUPPRESS);
    float modeRecognized = saturate(
        modeNone + modeHard + modeSoft + modeFar + modeNear);

    float missingReject = CAMERA_OBSCURA_API_DepthGateValueNear(
        depthMissingMode,
        CAMERA_OBSCURA_API_DEPTH_MISSING_REJECT);
    float missingPass = CAMERA_OBSCURA_API_DepthGateValueNear(
        depthMissingMode,
        CAMERA_OBSCURA_API_DEPTH_MISSING_PASS);
    float missingModeRecognized = saturate(missingReject + missingPass);

    float centerDepthSafe = saturate(centerDepth);
    float sampleDepthSafe = saturate(sampleDepth);
    float depthAvailableSafe = saturate(depthAvailable);
    float rejectThresholdSafe = max(rejectThreshold, 0.000001);
    float rejectSoftnessSafe = max(rejectSoftness, 0.000001);
    float farStartSafe = saturate(farStart);
    float farFeatherSafe = max(farFeather, 0.000001);
    float nearEndSafe = saturate(nearEnd);
    float nearFeatherSafe = max(nearFeather, 0.000001);
    float depthDelta = abs(centerDepthSafe - sampleDepthSafe);
    float depthMissing = step(depthAvailableSafe, 0.0001);
    float softTransition = CAMERA_OBSCURA_API_DepthGateSmoothRange(
        rejectThresholdSafe,
        rejectSoftnessSafe,
        depthDelta);
    float farMask = CAMERA_OBSCURA_API_DepthGateSmoothRange(
        farStartSafe,
        farFeatherSafe,
        centerDepthSafe);
    float nearMask = 1.0 - CAMERA_OBSCURA_API_DepthGateSmoothRange(
        nearEndSafe,
        nearFeatherSafe,
        centerDepthSafe);
    float sameLayerHard = 1.0 - step(rejectThresholdSafe, depthDelta);
    float sameLayerSoft = 1.0 - softTransition;
    float activeWeight =
        modeHard * sameLayerHard +
        modeSoft * sameLayerSoft +
        modeFar * farMask * sameLayerSoft +
        modeNear * (1.0 - nearMask) * sameLayerSoft;
    float nonNoneWeight = lerp(activeWeight, missingPass, depthMissing);
    float recognizedWeight = lerp(nonNoneWeight, 1.0, modeNone);
    float expectedWeight = lerp(1.0, recognizedWeight, modeRecognized);
    float observedWeight = saturate(observedGateWeight);
    float observedConsistent = CAMERA_OBSCURA_API_DepthGateValueNear(
        observedWeight,
        expectedWeight);
    float fullPass = CAMERA_OBSCURA_API_DepthGateValueNear(expectedWeight, 1.0);
    float fullReject = CAMERA_OBSCURA_API_DepthGateValueNear(expectedWeight, 0.0);
    float partialWeight = saturate(1.0 - max(fullPass, fullReject));
    float adjusted = 0.0;

    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(centerDepthSafe, centerDepth));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(sampleDepthSafe, sampleDepth));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(depthAvailableSafe, depthAvailable));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(rejectThresholdSafe, rejectThreshold));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(rejectSoftnessSafe, rejectSoftness));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(farStartSafe, farStart));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(farFeatherSafe, farFeather));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(nearEndSafe, nearEnd));
    adjusted = max(adjusted, 1.0 - CAMERA_OBSCURA_API_DepthGateValueNear(nearFeatherSafe, nearFeather));

    evidence.valid = saturate(evidenceValid);
    evidence.gate_mode = gateMode;
    evidence.gate_mode_recognized = modeRecognized;
    evidence.depth_missing_mode = depthMissingMode;
    evidence.depth_missing_mode_recognized = missingModeRecognized;

    evidence.center_depth = centerDepthSafe;
    evidence.sample_depth = sampleDepthSafe;
    evidence.depth_available = depthAvailableSafe;
    evidence.depth_missing = depthMissing;
    evidence.depth_delta = depthDelta;

    evidence.reject_threshold = rejectThresholdSafe;
    evidence.reject_softness = rejectSoftnessSafe;
    evidence.far_start = farStartSafe;
    evidence.far_feather = farFeatherSafe;
    evidence.near_end = nearEndSafe;
    evidence.near_feather = nearFeatherSafe;
    evidence.parameters_adjusted = saturate(adjusted);

    evidence.missing_fallback_weight = missingPass;
    evidence.same_layer_hard_weight = sameLayerHard;
    evidence.same_layer_soft_weight = sameLayerSoft;
    evidence.far_mask = farMask;
    evidence.near_mask = nearMask;

    evidence.route_none = modeNone;
    evidence.route_hard = modeHard;
    evidence.route_soft = modeSoft;
    evidence.route_far = modeFar;
    evidence.route_near = modeNear;
    evidence.route_missing = saturate((1.0 - modeNone) * depthMissing);

    evidence.expected_gate_weight = saturate(expectedWeight);
    evidence.observed_gate_weight = observedWeight;
    evidence.observed_consistent = observedConsistent;
    evidence.full_pass = fullPass;
    evidence.full_reject = fullReject;
    evidence.partial_weight = partialWeight;
    evidence.gate_consistent = saturate(
        evidence.valid *
        modeRecognized *
        missingModeRecognized *
        observedConsistent);

    evidence.request_stamp = requestStamp;
    evidence.surface_stamp = surfaceStamp;
    evidence.sample_stamp = sampleStamp;
    evidence.policy_stamp = policyStamp;
    evidence.gate_stamp = gateStamp;
    evidence.generation_stamp = generationStamp;
    evidence.source_stage_stamp = sourceStageStamp;
    return evidence;
}

float CAMERA_OBSCURA_API_DepthGateClass(
    CAMERA_OBSCURA_API_DepthGateEvidence evidence)
{
    float invalid = 1.0 - step(0.5, evidence.gate_consistent);
    float bypass = step(0.5, evidence.route_none) * (1.0 - invalid);
    float weighted = step(0.5, evidence.partial_weight) * (1.0 - invalid);
    float gateClass = CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BINARY;
    gateClass = lerp(
        gateClass,
        CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_WEIGHTED,
        weighted);
    gateClass = lerp(
        gateClass,
        CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BYPASS,
        bypass);
    gateClass = lerp(
        gateClass,
        CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_INVALID,
        invalid);
    return gateClass;
}

#endif // CAMERA_OBSCURA_API_DEPTH_GATE_EVIDENCE_FXH
