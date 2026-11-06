// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TWIN_LANTERN_TEMPORAL_MOTION_FXH
#define CAMERA_OBSCURA_API_TWIN_LANTERN_TEMPORAL_MOTION_FXH

#include "CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh"

struct CAMERA_OBSCURA_API_TL08TemporalMotionEvidence
{
    float history_valid;
    float same_uv_valid;
    float inferred_vector_valid;
    float2 inferred_vector_uv;
    float inferred_vector_pixels;
    float vector_match_error;
    float vector_confidence;
    float nonvector_source_change;
    float nonvector_transport_change;
    float vector_transport_change;
    float explained_motion;
    float residual_noise;
    float target_score;
};

CAMERA_OBSCURA_API_TL08TemporalMotionEvidence
CAMERA_OBSCURA_API_DefaultTL08TemporalMotionEvidence()
{
    CAMERA_OBSCURA_API_TL08TemporalMotionEvidence evidence;
    evidence.history_valid = 0.0;
    evidence.same_uv_valid = 0.0;
    evidence.inferred_vector_valid = 0.0;
    evidence.inferred_vector_uv = float2(0.0, 0.0);
    evidence.inferred_vector_pixels = 0.0;
    evidence.vector_match_error = 0.0;
    evidence.vector_confidence = 0.0;
    evidence.nonvector_source_change = 0.0;
    evidence.nonvector_transport_change = 0.0;
    evidence.vector_transport_change = 0.0;
    evidence.explained_motion = 0.0;
    evidence.residual_noise = 0.0;
    evidence.target_score = 0.0;
    return evidence;
}

CAMERA_OBSCURA_API_TL08TemporalMotionEvidence
CAMERA_OBSCURA_API_BuildTL08TemporalMotionEvidence(
    float3 currentSource,
    float3 sameUvHistorySource,
    float3 currentTransport,
    float3 sameUvHistoryTransport,
    float3 vectorHistoryTransport,
    float sameUvValid,
    float inferredVectorValid,
    float2 inferredVectorUv,
    float vectorMatchError,
    float targetScore,
    float confidenceErrorStart,
    float confidenceErrorFull)
{
    CAMERA_OBSCURA_API_TL08TemporalMotionEvidence evidence =
        CAMERA_OBSCURA_API_DefaultTL08TemporalMotionEvidence();
    float sameValid = saturate(sameUvValid);
    float vectorValid = saturate(inferredVectorValid);
    float safeErrorStart = max(confidenceErrorStart, 0.0);
    float safeErrorFull = max(
        confidenceErrorFull, safeErrorStart + 0.000001);
    float errorGate = CAMERA_OBSCURA_API_TL08SmoothGate(
        vectorMatchError, safeErrorStart, safeErrorFull);
    float vectorConfidence = vectorValid * (1.0 - errorGate);
    float nonvectorSourceChange = CAMERA_OBSCURA_Luma(
        abs(currentSource - sameUvHistorySource)) * sameValid;
    float nonvectorTransportChange = CAMERA_OBSCURA_Luma(
        abs(currentTransport - sameUvHistoryTransport)) * sameValid;
    float vectorTransportChange = CAMERA_OBSCURA_Luma(
        abs(currentTransport - vectorHistoryTransport)) * vectorValid;
    float explainedMotion = max(
        nonvectorTransportChange - vectorTransportChange, 0.0) *
        sameValid * vectorValid;
    float admittedTarget = saturate(targetScore);

    evidence.history_valid = max(sameValid, vectorValid);
    evidence.same_uv_valid = sameValid;
    evidence.inferred_vector_valid = vectorValid;
    evidence.inferred_vector_uv = inferredVectorUv * vectorValid;
    evidence.inferred_vector_pixels = length(float2(
        inferredVectorUv.x / max(BUFFER_RCP_WIDTH * 2.0, 0.000001),
        inferredVectorUv.y / max(BUFFER_RCP_HEIGHT * 2.0, 0.000001))) *
        vectorValid;
    evidence.vector_match_error = vectorMatchError * vectorValid;
    evidence.vector_confidence = vectorConfidence;
    evidence.nonvector_source_change = nonvectorSourceChange;
    evidence.nonvector_transport_change = nonvectorTransportChange;
    evidence.vector_transport_change = vectorTransportChange;
    evidence.explained_motion = explainedMotion;
    evidence.residual_noise = saturate(
        vectorTransportChange * vectorConfidence * admittedTarget);
    evidence.target_score = admittedTarget;
    return evidence;
}

#endif // CAMERA_OBSCURA_API_TWIN_LANTERN_TEMPORAL_MOTION_FXH
