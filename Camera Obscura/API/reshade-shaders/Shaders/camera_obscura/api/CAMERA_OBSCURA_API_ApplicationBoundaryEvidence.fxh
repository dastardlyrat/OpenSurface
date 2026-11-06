// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

    #ifndef CAMERA_OBSCURA_API_APPLICATION_BOUNDARY_EVIDENCE_FXH
    #define CAMERA_OBSCURA_API_APPLICATION_BOUNDARY_EVIDENCE_FXH
    #include "CAMERA_OBSCURA_API_Common.fxh"
    #define CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_BYPASS 0.0
    #define CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_REJECTED 1.0
    #define CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_APPLIED 2.0
    #define CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_INVALID 3.0

    // CO-MIG-016 observes an already-completed application stage. It validates
    // donor readiness, normalized strength/energy, supplied adjustment flags,
    // contribution/composite output, terminal reason, application state, and
    // provenance. It performs no transport, contribution, or composite work.
    struct CAMERA_OBSCURA_API_ApplicationBoundaryEvidence
    {
        float valid;
    float source_valid;
    float donor_valid;
    float donor_accepted;
    float donor_flags_binary;
    float application_ready;
    float requested_strength;
    float effective_strength;
    float strength_values_valid;
    float strength_consistent;
    float confidence;
    float requested_energy;
    float effective_energy;
    float energy_values_valid;
    float energy_consistent;
    float expected_adjustment_flags;
    float observed_adjustment_flags;
    float adjustment_values_valid;
    float adjustment_consistent;
    float expected_contribution_r;
    float expected_contribution_g;
    float expected_contribution_b;
    float observed_contribution_r;
    float observed_contribution_g;
    float observed_contribution_b;
    float contribution_values_valid;
    float contribution_consistent;
    float expected_composite_r;
    float expected_composite_g;
    float expected_composite_b;
    float observed_composite_r;
    float observed_composite_g;
    float observed_composite_b;
    float composite_values_valid;
    float composite_consistent;
    float expected_applied;
    float observed_applied;
    float applied_binary;
    float applied_consistent;
    float applied_readiness_consistent;
    float expected_reason;
    float observed_reason;
    float reason_values_valid;
    float reason_consistent;
    float applied_reason_consistent;
    float donor_stamp;
    float policy_stamp;
    float energy_stamp;
    float application_stamp;
    float generation_stamp;
    float source_stage_stamp;
    };

float CAMERA_OBSCURA_API_ApplicationEvidence_Near(float leftValue, float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_ApplicationEvidence_LessEqual(float value, float upperBound)
{
    return 1.0 - step(0.0001, value - upperBound);
}

float CAMERA_OBSCURA_API_ApplicationEvidence_Binary(float value)
{
    return saturate(CAMERA_OBSCURA_API_ApplicationEvidence_Near(value, 0.0) + CAMERA_OBSCURA_API_ApplicationEvidence_Near(value, 1.0));
}

float CAMERA_OBSCURA_API_ApplicationEvidence_Whole(float value)
{
    return CAMERA_OBSCURA_API_ApplicationEvidence_Near(value, floor(value + 0.5));
}

float CAMERA_OBSCURA_API_ApplicationEvidence_Range(float value, float minimumValue, float maximumValue)
{
    return step(minimumValue - 0.0001, value) *
        CAMERA_OBSCURA_API_ApplicationEvidence_LessEqual(value, maximumValue);
}


    CAMERA_OBSCURA_API_ApplicationBoundaryEvidence CAMERA_OBSCURA_API_DefaultApplicationBoundaryEvidence()
    {
        CAMERA_OBSCURA_API_ApplicationBoundaryEvidence evidence;
        evidence.valid = 0.0;
    evidence.source_valid = 0.0;
    evidence.donor_valid = 0.0;
    evidence.donor_accepted = 0.0;
    evidence.donor_flags_binary = 0.0;
    evidence.application_ready = 0.0;
    evidence.requested_strength = 0.0;
    evidence.effective_strength = 0.0;
    evidence.strength_values_valid = 0.0;
    evidence.strength_consistent = 0.0;
    evidence.confidence = 0.0;
    evidence.requested_energy = 0.0;
    evidence.effective_energy = 0.0;
    evidence.energy_values_valid = 0.0;
    evidence.energy_consistent = 0.0;
    evidence.expected_adjustment_flags = 0.0;
    evidence.observed_adjustment_flags = 0.0;
    evidence.adjustment_values_valid = 0.0;
    evidence.adjustment_consistent = 0.0;
    evidence.expected_contribution_r = 0.0;
    evidence.expected_contribution_g = 0.0;
    evidence.expected_contribution_b = 0.0;
    evidence.observed_contribution_r = 0.0;
    evidence.observed_contribution_g = 0.0;
    evidence.observed_contribution_b = 0.0;
    evidence.contribution_values_valid = 0.0;
    evidence.contribution_consistent = 0.0;
    evidence.expected_composite_r = 0.0;
    evidence.expected_composite_g = 0.0;
    evidence.expected_composite_b = 0.0;
    evidence.observed_composite_r = 0.0;
    evidence.observed_composite_g = 0.0;
    evidence.observed_composite_b = 0.0;
    evidence.composite_values_valid = 0.0;
    evidence.composite_consistent = 0.0;
    evidence.expected_applied = 0.0;
    evidence.observed_applied = 0.0;
    evidence.applied_binary = 0.0;
    evidence.applied_consistent = 0.0;
    evidence.applied_readiness_consistent = 0.0;
    evidence.expected_reason = 0.0;
    evidence.observed_reason = 0.0;
    evidence.reason_values_valid = 0.0;
    evidence.reason_consistent = 0.0;
    evidence.applied_reason_consistent = 0.0;
    evidence.donor_stamp = 0.0;
    evidence.policy_stamp = 0.0;
    evidence.energy_stamp = 0.0;
    evidence.application_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
        return evidence;
    }

    CAMERA_OBSCURA_API_ApplicationBoundaryEvidence CAMERA_OBSCURA_API_BuildApplicationBoundaryEvidence(
        float donorValid,float donorAccepted,float requestedStrength,float effectiveStrength,float confidence,
        float requestedEnergy,float effectiveEnergy,float expectedAdjustmentFlags,float observedAdjustmentFlags,
        float3 expectedContribution,float3 observedContribution,float3 expectedComposite,float3 observedComposite,
        float expectedApplied,float observedApplied,float expectedReason,float observedReason,float evidenceValid,
        float donorStamp,float policyStamp,float energyStamp,float applicationStamp,float generationStamp,float sourceStageStamp)
    {
        CAMERA_OBSCURA_API_ApplicationBoundaryEvidence evidence=CAMERA_OBSCURA_API_DefaultApplicationBoundaryEvidence();
        float sourceValid=CAMERA_OBSCURA_API_ApplicationEvidence_Binary(evidenceValid)*step(0.5,evidenceValid);
        float donorFlagsBinary=CAMERA_OBSCURA_API_ApplicationEvidence_Binary(donorValid)*CAMERA_OBSCURA_API_ApplicationEvidence_Binary(donorAccepted);
        float applicationReady=donorValid*donorAccepted;
        float strengthValuesValid=CAMERA_OBSCURA_API_ApplicationEvidence_Range(requestedStrength,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(effectiveStrength,0.0,1.0);
        float strengthConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_LessEqual(effectiveStrength,requestedStrength+0.0001);
        float energyValuesValid=CAMERA_OBSCURA_API_ApplicationEvidence_Range(confidence,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(requestedEnergy,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(effectiveEnergy,0.0,1.0);
        float energyConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_LessEqual(effectiveEnergy,requestedEnergy+0.0001);
        float adjustmentValuesValid=CAMERA_OBSCURA_API_ApplicationEvidence_Whole(expectedAdjustmentFlags)*CAMERA_OBSCURA_API_ApplicationEvidence_Whole(observedAdjustmentFlags)*
            CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedAdjustmentFlags,0.0,65535.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedAdjustmentFlags,0.0,65535.0);
        float adjustmentConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedAdjustmentFlags,observedAdjustmentFlags);
        float contributionValuesValid=
            CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedContribution.r,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedContribution.g,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedContribution.b,0.0,1.0)*
            CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedContribution.r,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedContribution.g,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedContribution.b,0.0,1.0);
        float contributionConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedContribution.r,observedContribution.r)*CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedContribution.g,observedContribution.g)*CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedContribution.b,observedContribution.b);
        float compositeValuesValid=
            CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedComposite.r,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedComposite.g,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedComposite.b,0.0,1.0)*
            CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedComposite.r,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedComposite.g,0.0,1.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedComposite.b,0.0,1.0);
        float compositeConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedComposite.r,observedComposite.r)*CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedComposite.g,observedComposite.g)*CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedComposite.b,observedComposite.b);
        float appliedBinary=CAMERA_OBSCURA_API_ApplicationEvidence_Binary(expectedApplied)*CAMERA_OBSCURA_API_ApplicationEvidence_Binary(observedApplied);
        float appliedConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedApplied,observedApplied);
        float appliedReadinessConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(observedApplied*(1.0-applicationReady*step(0.0001,effectiveStrength)),0.0);
        float reasonValuesValid=CAMERA_OBSCURA_API_ApplicationEvidence_Whole(expectedReason)*CAMERA_OBSCURA_API_ApplicationEvidence_Whole(observedReason)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(expectedReason,0.0,255.0)*CAMERA_OBSCURA_API_ApplicationEvidence_Range(observedReason,0.0,255.0);
        float reasonConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(expectedReason,observedReason);
        float appliedReasonConsistent=CAMERA_OBSCURA_API_ApplicationEvidence_Near(observedApplied*observedReason,0.0);
        float stampsValid=step(0.0001,donorStamp)*step(0.0001,policyStamp)*step(0.0001,energyStamp)*step(0.0001,applicationStamp)*step(0.0001,generationStamp)*step(0.0001,sourceStageStamp);

        evidence.source_valid=sourceValid; evidence.donor_valid=donorValid; evidence.donor_accepted=donorAccepted; evidence.donor_flags_binary=donorFlagsBinary; evidence.application_ready=applicationReady;
        evidence.requested_strength=requestedStrength; evidence.effective_strength=effectiveStrength; evidence.strength_values_valid=strengthValuesValid; evidence.strength_consistent=strengthConsistent;
        evidence.confidence=confidence; evidence.requested_energy=requestedEnergy; evidence.effective_energy=effectiveEnergy; evidence.energy_values_valid=energyValuesValid; evidence.energy_consistent=energyConsistent;
        evidence.expected_adjustment_flags=expectedAdjustmentFlags; evidence.observed_adjustment_flags=observedAdjustmentFlags; evidence.adjustment_values_valid=adjustmentValuesValid; evidence.adjustment_consistent=adjustmentConsistent;
        evidence.expected_contribution_r=expectedContribution.r; evidence.expected_contribution_g=expectedContribution.g; evidence.expected_contribution_b=expectedContribution.b;
        evidence.observed_contribution_r=observedContribution.r; evidence.observed_contribution_g=observedContribution.g; evidence.observed_contribution_b=observedContribution.b; evidence.contribution_values_valid=contributionValuesValid; evidence.contribution_consistent=contributionConsistent;
        evidence.expected_composite_r=expectedComposite.r; evidence.expected_composite_g=expectedComposite.g; evidence.expected_composite_b=expectedComposite.b;
        evidence.observed_composite_r=observedComposite.r; evidence.observed_composite_g=observedComposite.g; evidence.observed_composite_b=observedComposite.b; evidence.composite_values_valid=compositeValuesValid; evidence.composite_consistent=compositeConsistent;
        evidence.expected_applied=expectedApplied; evidence.observed_applied=observedApplied; evidence.applied_binary=appliedBinary; evidence.applied_consistent=appliedConsistent; evidence.applied_readiness_consistent=appliedReadinessConsistent;
        evidence.expected_reason=expectedReason; evidence.observed_reason=observedReason; evidence.reason_values_valid=reasonValuesValid; evidence.reason_consistent=reasonConsistent; evidence.applied_reason_consistent=appliedReasonConsistent;
        evidence.donor_stamp=donorStamp; evidence.policy_stamp=policyStamp; evidence.energy_stamp=energyStamp; evidence.application_stamp=applicationStamp; evidence.generation_stamp=generationStamp; evidence.source_stage_stamp=sourceStageStamp;
        evidence.valid=sourceValid*donorFlagsBinary*strengthValuesValid*strengthConsistent*energyValuesValid*energyConsistent*adjustmentValuesValid*adjustmentConsistent*contributionValuesValid*contributionConsistent*compositeValuesValid*compositeConsistent*appliedBinary*appliedConsistent*appliedReadinessConsistent*reasonValuesValid*reasonConsistent*appliedReasonConsistent*stampsValid;
        return evidence;
    }

    float CAMERA_OBSCURA_API_ApplicationBoundaryClass(CAMERA_OBSCURA_API_ApplicationBoundaryEvidence evidence)
    {
        float valid=step(0.5,evidence.valid); float ready=step(0.5,evidence.application_ready); float strengthActive=step(0.0001,evidence.effective_strength); float applied=step(0.5,evidence.observed_applied);
        float bypass=ready*(1.0-strengthActive); float rejected=saturate((1.0-ready)+ready*strengthActive*(1.0-applied)); float appliedClass=ready*strengthActive*applied;
        float classValue=bypass*CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_BYPASS+rejected*CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_REJECTED+appliedClass*CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_APPLIED;
        return lerp(CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_INVALID,classValue,valid);
    }
    #endif
