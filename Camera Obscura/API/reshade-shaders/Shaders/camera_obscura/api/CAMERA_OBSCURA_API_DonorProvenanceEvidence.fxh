// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

    #ifndef CAMERA_OBSCURA_API_DONOR_PROVENANCE_EVIDENCE_FXH
    #define CAMERA_OBSCURA_API_DONOR_PROVENANCE_EVIDENCE_FXH

    #include "CAMERA_OBSCURA_API_Common.fxh"

    #define CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_NO_TRACE 0.0
    #define CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_REJECTED 1.0
    #define CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_ACCEPTED 2.0
    #define CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_INVALID 3.0

    // CO-MIG-015 observes an already-completed donor stage. It validates
    // readiness, candidate/selection lineage, supplied metrics and gates,
    // terminal acceptance/rejection evidence, and provenance. It performs no
    // candidate search, policy evaluation, color acquisition, or application.
    struct CAMERA_OBSCURA_API_DonorProvenanceEvidence
    {
        float valid;
    float source_valid;
    float trace_ready;
    float trace_ready_binary;
    float candidate_count;
    float candidate_count_valid;
    float selected_index;
    float selected_index_valid;
    float selected_in_range;
    float selection_state_consistent;
    float receiver_u;
    float receiver_v;
    float receiver_uv_valid;
    float selected_u;
    float selected_v;
    float selected_uv_valid;
    float edge_safety;
    float donor_chroma;
    float color_delta;
    float donor_luma;
    float normal_compatibility;
    float score;
    float metrics_valid;
    float edge_gate;
    float chroma_gate;
    float delta_gate;
    float luma_gate;
    float normal_gate;
    float score_gate;
    float gates_binary;
    float expected_accepted;
    float observed_accepted;
    float acceptance_binary;
    float acceptance_consistent;
    float accepted_gate_consistent;
    float expected_reason;
    float observed_reason;
    float reason_values_valid;
    float reason_consistent;
    float accepted_reason_consistent;
    float expected_reject_mask;
    float observed_reject_mask;
    float reject_mask_values_valid;
    float reject_mask_consistent;
    float accepted_mask_consistent;
    float request_stamp;
    float trace_stamp;
    float selection_stamp;
    float evaluation_stamp;
    float generation_stamp;
    float source_stage_stamp;
    };


float CAMERA_OBSCURA_API_DonorEvidence_Near(float leftValue, float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_DonorEvidence_LessEqual(float value, float upperBound)
{
    return 1.0 - step(0.0001, value - upperBound);
}

float CAMERA_OBSCURA_API_DonorEvidence_Binary(float value)
{
    return saturate(CAMERA_OBSCURA_API_DonorEvidence_Near(value, 0.0) + CAMERA_OBSCURA_API_DonorEvidence_Near(value, 1.0));
}

float CAMERA_OBSCURA_API_DonorEvidence_Whole(float value)
{
    return CAMERA_OBSCURA_API_DonorEvidence_Near(value, floor(value + 0.5));
}

float CAMERA_OBSCURA_API_DonorEvidence_Range(float value, float minimumValue, float maximumValue)
{
    return step(minimumValue - 0.0001, value) *
        CAMERA_OBSCURA_API_DonorEvidence_LessEqual(value, maximumValue);
}


    CAMERA_OBSCURA_API_DonorProvenanceEvidence
    CAMERA_OBSCURA_API_DefaultDonorProvenanceEvidence()
    {
        CAMERA_OBSCURA_API_DonorProvenanceEvidence evidence;
        evidence.valid = 0.0;
    evidence.source_valid = 0.0;
    evidence.trace_ready = 0.0;
    evidence.trace_ready_binary = 0.0;
    evidence.candidate_count = 0.0;
    evidence.candidate_count_valid = 0.0;
    evidence.selected_index = 0.0;
    evidence.selected_index_valid = 0.0;
    evidence.selected_in_range = 0.0;
    evidence.selection_state_consistent = 0.0;
    evidence.receiver_u = 0.0;
    evidence.receiver_v = 0.0;
    evidence.receiver_uv_valid = 0.0;
    evidence.selected_u = 0.0;
    evidence.selected_v = 0.0;
    evidence.selected_uv_valid = 0.0;
    evidence.edge_safety = 0.0;
    evidence.donor_chroma = 0.0;
    evidence.color_delta = 0.0;
    evidence.donor_luma = 0.0;
    evidence.normal_compatibility = 0.0;
    evidence.score = 0.0;
    evidence.metrics_valid = 0.0;
    evidence.edge_gate = 0.0;
    evidence.chroma_gate = 0.0;
    evidence.delta_gate = 0.0;
    evidence.luma_gate = 0.0;
    evidence.normal_gate = 0.0;
    evidence.score_gate = 0.0;
    evidence.gates_binary = 0.0;
    evidence.expected_accepted = 0.0;
    evidence.observed_accepted = 0.0;
    evidence.acceptance_binary = 0.0;
    evidence.acceptance_consistent = 0.0;
    evidence.accepted_gate_consistent = 0.0;
    evidence.expected_reason = 0.0;
    evidence.observed_reason = 0.0;
    evidence.reason_values_valid = 0.0;
    evidence.reason_consistent = 0.0;
    evidence.accepted_reason_consistent = 0.0;
    evidence.expected_reject_mask = 0.0;
    evidence.observed_reject_mask = 0.0;
    evidence.reject_mask_values_valid = 0.0;
    evidence.reject_mask_consistent = 0.0;
    evidence.accepted_mask_consistent = 0.0;
    evidence.request_stamp = 0.0;
    evidence.trace_stamp = 0.0;
    evidence.selection_stamp = 0.0;
    evidence.evaluation_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
        return evidence;
    }

    CAMERA_OBSCURA_API_DonorProvenanceEvidence
    CAMERA_OBSCURA_API_BuildDonorProvenanceEvidence(
        float traceReady,
        float candidateCount,
        float selectedIndex,
        float receiverU,
        float receiverV,
        float selectedU,
        float selectedV,
        float edgeSafety,
        float donorChroma,
        float colorDelta,
        float donorLuma,
        float normalCompatibility,
        float score,
        float edgeGate,
        float chromaGate,
        float deltaGate,
        float lumaGate,
        float normalGate,
        float scoreGate,
        float expectedAccepted,
        float observedAccepted,
        float expectedReason,
        float observedReason,
        float expectedRejectMask,
        float observedRejectMask,
        float evidenceValid,
        float requestStamp,
        float traceStamp,
        float selectionStamp,
        float evaluationStamp,
        float generationStamp,
        float sourceStageStamp)
    {
        CAMERA_OBSCURA_API_DonorProvenanceEvidence evidence =
            CAMERA_OBSCURA_API_DefaultDonorProvenanceEvidence();

        float sourceValid = CAMERA_OBSCURA_API_DonorEvidence_Binary(evidenceValid) * step(0.5, evidenceValid);
        float traceBinary = CAMERA_OBSCURA_API_DonorEvidence_Binary(traceReady);
        float countValid = CAMERA_OBSCURA_API_DonorEvidence_Whole(candidateCount) * CAMERA_OBSCURA_API_DonorEvidence_Range(candidateCount, 0.0, 64.0);
        float indexValid = CAMERA_OBSCURA_API_DonorEvidence_Whole(selectedIndex) * CAMERA_OBSCURA_API_DonorEvidence_Range(selectedIndex, 0.0, 63.0);
        float selectedInRange =
            (1.0 - step(0.5, traceReady)) * CAMERA_OBSCURA_API_DonorEvidence_Near(selectedIndex, 0.0) +
            step(0.5, traceReady) * step(selectedIndex + 0.5, candidateCount);
        selectedInRange = saturate(selectedInRange);
        float selectionStateConsistent =
            (1.0 - step(0.5, traceReady)) *
                CAMERA_OBSCURA_API_DonorEvidence_Near(candidateCount, 0.0) *
                CAMERA_OBSCURA_API_DonorEvidence_Near(selectedIndex, 0.0) *
                CAMERA_OBSCURA_API_DonorEvidence_Near(selectedU, receiverU) *
                CAMERA_OBSCURA_API_DonorEvidence_Near(selectedV, receiverV) +
            step(0.5, traceReady) * step(0.5, candidateCount) * selectedInRange;
        selectionStateConsistent = saturate(selectionStateConsistent);

        float receiverUvValid = CAMERA_OBSCURA_API_DonorEvidence_Range(receiverU, 0.0, 1.0) * CAMERA_OBSCURA_API_DonorEvidence_Range(receiverV, 0.0, 1.0);
        float selectedUvValid = CAMERA_OBSCURA_API_DonorEvidence_Range(selectedU, 0.0, 1.0) * CAMERA_OBSCURA_API_DonorEvidence_Range(selectedV, 0.0, 1.0);
        float metricsValid =
            CAMERA_OBSCURA_API_DonorEvidence_Range(edgeSafety, 0.0, 1.0) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(donorChroma, 0.0, 1.0) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(colorDelta, 0.0, 1.0) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(donorLuma, 0.0, 1.0) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(normalCompatibility, 0.0, 1.0) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(score, 0.0, 1.0);
        float gatesBinary =
            CAMERA_OBSCURA_API_DonorEvidence_Binary(edgeGate) * CAMERA_OBSCURA_API_DonorEvidence_Binary(chromaGate) *
            CAMERA_OBSCURA_API_DonorEvidence_Binary(deltaGate) * CAMERA_OBSCURA_API_DonorEvidence_Binary(lumaGate) *
            CAMERA_OBSCURA_API_DonorEvidence_Binary(normalGate) * CAMERA_OBSCURA_API_DonorEvidence_Binary(scoreGate);
        float gateProduct = edgeGate * chromaGate * deltaGate * lumaGate * normalGate * scoreGate;

        float acceptanceBinary = CAMERA_OBSCURA_API_DonorEvidence_Binary(expectedAccepted) * CAMERA_OBSCURA_API_DonorEvidence_Binary(observedAccepted);
        float acceptanceConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(expectedAccepted, observedAccepted);
        float acceptedGateConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(observedAccepted * (1.0 - traceReady * gateProduct), 0.0);
        float reasonValuesValid = CAMERA_OBSCURA_API_DonorEvidence_Whole(expectedReason) * CAMERA_OBSCURA_API_DonorEvidence_Whole(observedReason) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(expectedReason, 0.0, 255.0) * CAMERA_OBSCURA_API_DonorEvidence_Range(observedReason, 0.0, 255.0);
        float reasonConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(expectedReason, observedReason);
        float acceptedReasonConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(observedAccepted * observedReason, 0.0);
        float rejectMaskValuesValid = CAMERA_OBSCURA_API_DonorEvidence_Whole(expectedRejectMask) * CAMERA_OBSCURA_API_DonorEvidence_Whole(observedRejectMask) *
            CAMERA_OBSCURA_API_DonorEvidence_Range(expectedRejectMask, 0.0, 65535.0) * CAMERA_OBSCURA_API_DonorEvidence_Range(observedRejectMask, 0.0, 65535.0);
        float rejectMaskConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(expectedRejectMask, observedRejectMask);
        float acceptedMaskConsistent = CAMERA_OBSCURA_API_DonorEvidence_Near(observedAccepted * observedRejectMask, 0.0);
        float stampsValid = step(0.0001, requestStamp) * step(0.0001, traceStamp) *
            step(0.0001, selectionStamp) * step(0.0001, evaluationStamp) *
            step(0.0001, generationStamp) * step(0.0001, sourceStageStamp);

        evidence.source_valid = sourceValid;
        evidence.trace_ready = traceReady;
        evidence.trace_ready_binary = traceBinary;
        evidence.candidate_count = candidateCount;
        evidence.candidate_count_valid = countValid;
        evidence.selected_index = selectedIndex;
        evidence.selected_index_valid = indexValid;
        evidence.selected_in_range = selectedInRange;
        evidence.selection_state_consistent = selectionStateConsistent;
        evidence.receiver_u = receiverU;
        evidence.receiver_v = receiverV;
        evidence.receiver_uv_valid = receiverUvValid;
        evidence.selected_u = selectedU;
        evidence.selected_v = selectedV;
        evidence.selected_uv_valid = selectedUvValid;
        evidence.edge_safety = edgeSafety;
        evidence.donor_chroma = donorChroma;
        evidence.color_delta = colorDelta;
        evidence.donor_luma = donorLuma;
        evidence.normal_compatibility = normalCompatibility;
        evidence.score = score;
        evidence.metrics_valid = metricsValid;
        evidence.edge_gate = edgeGate;
        evidence.chroma_gate = chromaGate;
        evidence.delta_gate = deltaGate;
        evidence.luma_gate = lumaGate;
        evidence.normal_gate = normalGate;
        evidence.score_gate = scoreGate;
        evidence.gates_binary = gatesBinary;
        evidence.expected_accepted = expectedAccepted;
        evidence.observed_accepted = observedAccepted;
        evidence.acceptance_binary = acceptanceBinary;
        evidence.acceptance_consistent = acceptanceConsistent;
        evidence.accepted_gate_consistent = acceptedGateConsistent;
        evidence.expected_reason = expectedReason;
        evidence.observed_reason = observedReason;
        evidence.reason_values_valid = reasonValuesValid;
        evidence.reason_consistent = reasonConsistent;
        evidence.accepted_reason_consistent = acceptedReasonConsistent;
        evidence.expected_reject_mask = expectedRejectMask;
        evidence.observed_reject_mask = observedRejectMask;
        evidence.reject_mask_values_valid = rejectMaskValuesValid;
        evidence.reject_mask_consistent = rejectMaskConsistent;
        evidence.accepted_mask_consistent = acceptedMaskConsistent;
        evidence.request_stamp = requestStamp;
        evidence.trace_stamp = traceStamp;
        evidence.selection_stamp = selectionStamp;
        evidence.evaluation_stamp = evaluationStamp;
        evidence.generation_stamp = generationStamp;
        evidence.source_stage_stamp = sourceStageStamp;
        evidence.valid = sourceValid * traceBinary * countValid * indexValid * selectedInRange *
            selectionStateConsistent * receiverUvValid * selectedUvValid * metricsValid * gatesBinary *
            acceptanceBinary * acceptanceConsistent * acceptedGateConsistent * reasonValuesValid *
            reasonConsistent * acceptedReasonConsistent * rejectMaskValuesValid * rejectMaskConsistent *
            acceptedMaskConsistent * stampsValid;
        return evidence;
    }

    float CAMERA_OBSCURA_API_DonorProvenanceClass(
        CAMERA_OBSCURA_API_DonorProvenanceEvidence evidence)
    {
        float traceActive = step(0.5, evidence.trace_ready);
        float accepted = step(0.5, evidence.observed_accepted);
        float valid = step(0.5, evidence.valid);
        float validClass = traceActive * ((1.0 - accepted) *
            CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_REJECTED + accepted *
            CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_ACCEPTED);
        return lerp(CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_INVALID, validClass, valid);
    }

    #endif
