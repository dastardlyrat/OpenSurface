// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_EVIDENCE_FXH
#define CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_EVIDENCE_FXH

#include "CAMERA_OBSCURA_API_Common.fxh"

#define CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_MISS 0.0
#define CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_CHANGED 1.0
#define CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_STABLE 2.0
#define CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_INVALID 3.0

// CO-MIG-008 records an already-observed provider lifecycle. It does not invoke,
// repeat, replace, or wrap traversal. Initial, coarse, refinement, and final
// evidence remain flat so the provider boundary stays inspectable.
struct CAMERA_OBSCURA_API_ProviderLifecycleEvidence
{
    float valid;

    float expected_backend;
    float ray_valid;
    float provider_attempted;
    float step_budget;

    float initial_valid;
    float initial_hit;
    float initial_reason;
    float initial_backend;
    float initial_step_index;
    float initial_miss_consistent;

    float coarse_valid;
    float coarse_hit;
    float coarse_reason;
    float coarse_backend;
    float coarse_step_index;
    float coarse_confidence;
    float coarse_bounded;
    float coarse_terminal_consistent;
    float coarse_backend_consistent;

    float refinement_requested;
    float refinement_eligible;
    float refinement_applied;
    float refinement_gate_consistent;
    float refinement_changed_uv;
    float refinement_changed_depth;
    float refinement_changed_confidence;
    float refinement_changed_any;

    float final_valid;
    float final_hit;
    float final_reason;
    float final_backend;
    float final_step_index;
    float final_confidence;
    float final_bounded;
    float final_terminal_consistent;
    float final_backend_consistent;
    float outcome_preserved;
    float step_index_preserved;
    float final_consistent;

    float lifecycle_consistent;

    float request_stamp;
    float control_stamp;
    float ray_stamp;
    float initial_stamp;
    float coarse_stamp;
    float final_stamp;
    float generation_stamp;
    float source_stage_stamp;
};

float CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
    float leftValue,
    float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_ProviderLifecycleVectorNear(
    float2 leftValue,
    float2 rightValue)
{
    float2 delta = leftValue - rightValue;
    return 1.0 - step(0.00000001, dot(delta, delta));
}

float CAMERA_OBSCURA_API_ProviderLifecycleTerminalConsistent(
    CAMERA_OBSCURA_Hit hit)
{
    float reasonIsHit = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        hit.reason,
        CAMERA_OBSCURA_REASON_HIT);
    float hitIsSet = step(0.5, hit.hit);
    float validIsSet = step(0.5, hit.valid);
    return saturate(min(
        validIsSet,
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            hitIsSet,
            reasonIsHit)));
}

float CAMERA_OBSCURA_API_ProviderLifecycleBounded(
    float stepIndex,
    float stepBudget)
{
    float nonNegative = step(-0.0001, stepIndex);
    float insideBudget = step(stepIndex, max(stepBudget, 0.0) + 0.0001);
    return saturate(nonNegative * insideBudget);
}

CAMERA_OBSCURA_API_ProviderLifecycleEvidence
CAMERA_OBSCURA_API_DefaultProviderLifecycleEvidence()
{
    CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence;
    evidence.valid = 0.0;

    evidence.expected_backend = CAMERA_OBSCURA_BACKEND_NONE;
    evidence.ray_valid = 0.0;
    evidence.provider_attempted = 0.0;
    evidence.step_budget = 0.0;

    evidence.initial_valid = 0.0;
    evidence.initial_hit = 0.0;
    evidence.initial_reason = CAMERA_OBSCURA_REASON_MAX_STEPS;
    evidence.initial_backend = CAMERA_OBSCURA_BACKEND_NONE;
    evidence.initial_step_index = 0.0;
    evidence.initial_miss_consistent = 0.0;

    evidence.coarse_valid = 0.0;
    evidence.coarse_hit = 0.0;
    evidence.coarse_reason = CAMERA_OBSCURA_REASON_MAX_STEPS;
    evidence.coarse_backend = CAMERA_OBSCURA_BACKEND_NONE;
    evidence.coarse_step_index = 0.0;
    evidence.coarse_confidence = 0.0;
    evidence.coarse_bounded = 0.0;
    evidence.coarse_terminal_consistent = 0.0;
    evidence.coarse_backend_consistent = 0.0;

    evidence.refinement_requested = 0.0;
    evidence.refinement_eligible = 0.0;
    evidence.refinement_applied = 0.0;
    evidence.refinement_gate_consistent = 0.0;
    evidence.refinement_changed_uv = 0.0;
    evidence.refinement_changed_depth = 0.0;
    evidence.refinement_changed_confidence = 0.0;
    evidence.refinement_changed_any = 0.0;

    evidence.final_valid = 0.0;
    evidence.final_hit = 0.0;
    evidence.final_reason = CAMERA_OBSCURA_REASON_MAX_STEPS;
    evidence.final_backend = CAMERA_OBSCURA_BACKEND_NONE;
    evidence.final_step_index = 0.0;
    evidence.final_confidence = 0.0;
    evidence.final_bounded = 0.0;
    evidence.final_terminal_consistent = 0.0;
    evidence.final_backend_consistent = 0.0;
    evidence.outcome_preserved = 0.0;
    evidence.step_index_preserved = 0.0;
    evidence.final_consistent = 0.0;

    evidence.lifecycle_consistent = 0.0;

    evidence.request_stamp = 0.0;
    evidence.control_stamp = 0.0;
    evidence.ray_stamp = 0.0;
    evidence.initial_stamp = 0.0;
    evidence.coarse_stamp = 0.0;
    evidence.final_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
    return evidence;
}

CAMERA_OBSCURA_API_ProviderLifecycleEvidence
CAMERA_OBSCURA_API_BuildProviderLifecycleEvidence(
    float expectedBackend,
    float rayValid,
    float providerAttempted,
    float stepBudget,
    CAMERA_OBSCURA_Hit initialHit,
    CAMERA_OBSCURA_Hit coarseHit,
    float refinementRequested,
    float refinementApplied,
    CAMERA_OBSCURA_Hit finalHit,
    float evidenceValid,
    float requestStamp,
    float controlStamp,
    float rayStamp,
    float initialStamp,
    float coarseStamp,
    float finalStamp,
    float generationStamp,
    float sourceStageStamp)
{
    CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence =
        CAMERA_OBSCURA_API_DefaultProviderLifecycleEvidence();
    float expectedInitialMiss = 1.0;
    float initialReasonConsistent = 0.0;
    float initialBackendConsistent = 0.0;
    float initialStepConsistent = 0.0;
    float expectedRefinementApplied = 0.0;
    float coarseOutcome = step(0.5, coarseHit.hit);
    float finalOutcome = step(0.5, finalHit.hit);
    float outcomePreserved = 0.0;
    float reasonPreserved = 0.0;
    float consistency = 1.0;

    evidence.valid = saturate(evidenceValid);
    evidence.expected_backend = expectedBackend;
    evidence.ray_valid = saturate(rayValid);
    evidence.provider_attempted = saturate(providerAttempted);
    evidence.step_budget = max(stepBudget, 0.0);

    evidence.initial_valid = initialHit.valid;
    evidence.initial_hit = initialHit.hit;
    evidence.initial_reason = initialHit.reason;
    evidence.initial_backend = initialHit.backend;
    evidence.initial_step_index = initialHit.step_index;
    initialReasonConsistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            initialHit.reason,
            CAMERA_OBSCURA_REASON_MAX_STEPS);
    initialBackendConsistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            initialHit.backend,
            expectedBackend);
    initialStepConsistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            initialHit.step_index,
            0.0);
    expectedInitialMiss = min(expectedInitialMiss, step(0.5, initialHit.valid));
    expectedInitialMiss = min(expectedInitialMiss, 1.0 - step(0.5, initialHit.hit));
    expectedInitialMiss = min(expectedInitialMiss, initialReasonConsistent);
    expectedInitialMiss = min(expectedInitialMiss, initialBackendConsistent);
    expectedInitialMiss = min(expectedInitialMiss, initialStepConsistent);
    evidence.initial_miss_consistent = saturate(expectedInitialMiss);

    evidence.coarse_valid = coarseHit.valid;
    evidence.coarse_hit = coarseHit.hit;
    evidence.coarse_reason = coarseHit.reason;
    evidence.coarse_backend = coarseHit.backend;
    evidence.coarse_step_index = coarseHit.step_index;
    evidence.coarse_confidence = coarseHit.confidence;
    evidence.coarse_bounded = CAMERA_OBSCURA_API_ProviderLifecycleBounded(
        coarseHit.step_index,
        evidence.step_budget);
    evidence.coarse_terminal_consistent =
        CAMERA_OBSCURA_API_ProviderLifecycleTerminalConsistent(coarseHit);
    evidence.coarse_backend_consistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            coarseHit.backend,
            expectedBackend);

    evidence.refinement_requested = max(refinementRequested, 0.0);
    evidence.refinement_eligible =
        coarseOutcome * step(0.5, evidence.refinement_requested);
    evidence.refinement_applied = saturate(refinementApplied);
    expectedRefinementApplied = evidence.refinement_eligible;
    evidence.refinement_gate_consistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            evidence.refinement_applied,
            expectedRefinementApplied);
    evidence.refinement_changed_uv = 1.0 -
        CAMERA_OBSCURA_API_ProviderLifecycleVectorNear(
            coarseHit.uv,
            finalHit.uv);
    evidence.refinement_changed_depth = max(
        1.0 - CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            coarseHit.ray_z,
            finalHit.ray_z),
        1.0 - CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            coarseHit.scene_z,
            finalHit.scene_z));
    evidence.refinement_changed_confidence = 1.0 -
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            coarseHit.confidence,
            finalHit.confidence);
    evidence.refinement_changed_any = max(
        evidence.refinement_changed_uv,
        max(
            evidence.refinement_changed_depth,
            evidence.refinement_changed_confidence));

    evidence.final_valid = finalHit.valid;
    evidence.final_hit = finalHit.hit;
    evidence.final_reason = finalHit.reason;
    evidence.final_backend = finalHit.backend;
    evidence.final_step_index = finalHit.step_index;
    evidence.final_confidence = finalHit.confidence;
    evidence.final_bounded = CAMERA_OBSCURA_API_ProviderLifecycleBounded(
        finalHit.step_index,
        evidence.step_budget);
    evidence.final_terminal_consistent =
        CAMERA_OBSCURA_API_ProviderLifecycleTerminalConsistent(finalHit);
    evidence.final_backend_consistent =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            finalHit.backend,
            expectedBackend);
    outcomePreserved = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        coarseOutcome,
        finalOutcome);
    reasonPreserved = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        coarseHit.reason,
        finalHit.reason);
    evidence.outcome_preserved = min(outcomePreserved, reasonPreserved);
    evidence.step_index_preserved =
        CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
            coarseHit.step_index,
            finalHit.step_index);
    evidence.final_consistent = saturate(min(
        min(evidence.final_bounded, evidence.final_terminal_consistent),
        min(
            evidence.final_backend_consistent,
            min(evidence.outcome_preserved, evidence.step_index_preserved))));

    consistency = min(consistency, evidence.valid);
    consistency = min(consistency, evidence.provider_attempted);
    consistency = min(consistency, evidence.initial_miss_consistent);
    consistency = min(consistency, evidence.coarse_bounded);
    consistency = min(consistency, evidence.coarse_terminal_consistent);
    consistency = min(consistency, evidence.coarse_backend_consistent);
    consistency = min(consistency, evidence.refinement_gate_consistent);
    consistency = min(consistency, evidence.final_consistent);
    evidence.lifecycle_consistent = saturate(consistency);

    evidence.request_stamp = requestStamp;
    evidence.control_stamp = controlStamp;
    evidence.ray_stamp = rayStamp;
    evidence.initial_stamp = initialStamp;
    evidence.coarse_stamp = coarseStamp;
    evidence.final_stamp = finalStamp;
    evidence.generation_stamp = generationStamp;
    evidence.source_stage_stamp = sourceStageStamp;
    return evidence;
}

float CAMERA_OBSCURA_API_ProviderLifecycleClass(
    CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence)
{
    // This helper may be evaluated per pixel by diagnostics. Keep the class
    // choice in predicate/select form while preserving the exact > 0.5 gates.
    float lifecycleValid =
        (evidence.valid > 0.5 && evidence.lifecycle_consistent > 0.5)
            ? 1.0
            : 0.0;
    float coarseHit = evidence.coarse_hit > 0.5 ? 1.0 : 0.0;
    float refinementChanged =
        evidence.refinement_changed_any > 0.5 ? 1.0 : 0.0;
    float hitClass = lerp(
        CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_STABLE,
        CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_CHANGED,
        refinementChanged);
    float validClass = lerp(
        CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_MISS,
        hitClass,
        coarseHit);
    float lifecycleClass = lerp(
        CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_INVALID,
        validClass,
        lifecycleValid);
    return lifecycleClass;
}

float CAMERA_OBSCURA_API_ProviderLifecycleStampMatch(
    CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence,
    float requestStamp,
    float controlStamp,
    float rayStamp,
    float initialStamp,
    float coarseStamp,
    float finalStamp,
    float generationStamp,
    float sourceStageStamp)
{
    float requestMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.request_stamp,
        requestStamp);
    float controlMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.control_stamp,
        controlStamp);
    float rayMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.ray_stamp,
        rayStamp);
    float initialMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.initial_stamp,
        initialStamp);
    float coarseMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.coarse_stamp,
        coarseStamp);
    float finalMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.final_stamp,
        finalStamp);
    float generationMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.generation_stamp,
        generationStamp);
    float stageMatch = CAMERA_OBSCURA_API_ProviderLifecycleValueNear(
        evidence.source_stage_stamp,
        sourceStageStamp);

    return saturate(min(
        min(min(requestMatch, controlMatch), min(rayMatch, initialMatch)),
        min(min(coarseMatch, finalMatch), min(generationMatch, stageMatch))));
}

#endif // CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_EVIDENCE_FXH
