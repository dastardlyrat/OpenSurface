// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

    #ifndef CAMERA_OBSCURA_API_SPATIAL_SUPPORT_EVIDENCE_FXH
    #define CAMERA_OBSCURA_API_SPATIAL_SUPPORT_EVIDENCE_FXH
    #include "CAMERA_OBSCURA_API_Common.fxh"
    #define CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_EMPTY 0.0
    #define CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_CENTER 1.0
    #define CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_SUPPORTED 2.0
    #define CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_INVALID 3.0

    // CO-MIG-017 observes already-resolved spatial support diagnostics. It
    // validates center state, neighbor-count/weight partition, supplied guards,
    // resolved/composite output, terminal state, and provenance. It performs no
    // neighborhood sampling, support weighting, or spatial resolve.
    struct CAMERA_OBSCURA_API_SpatialSupportEvidence
    {
        float valid;
    float source_valid;
    float center_valid;
    float center_applied;
    float center_flags_binary;
    float requested_neighbor_count;
    float available_neighbor_count;
    float accepted_neighbor_count;
    float count_values_valid;
    float count_partition_consistent;
    float weight_support_count;
    float support_count_consistent;
    float center_weight;
    float left_weight;
    float right_weight;
    float up_weight;
    float down_weight;
    float weights_valid;
    float expected_neighbor_weight_sum;
    float observed_neighbor_weight_sum;
    float neighbor_sum_consistent;
    float expected_total_weight;
    float observed_total_weight;
    float total_weight_consistent;
    float depth_support;
    float normal_support;
    float edge_support;
    float support_values_valid;
    float expected_resolved_r;
    float expected_resolved_g;
    float expected_resolved_b;
    float observed_resolved_r;
    float observed_resolved_g;
    float observed_resolved_b;
    float resolved_values_valid;
    float resolved_consistent;
    float expected_composite_r;
    float expected_composite_g;
    float expected_composite_b;
    float observed_composite_r;
    float observed_composite_g;
    float observed_composite_b;
    float composite_values_valid;
    float composite_consistent;
    float expected_state;
    float observed_state;
    float state_values_valid;
    float state_consistent;
    float center_stamp;
    float support_stamp;
    float resolve_stamp;
    float output_stamp;
    float generation_stamp;
    float source_stage_stamp;
    };

float CAMERA_OBSCURA_API_SpatialEvidence_Near(float leftValue, float rightValue)
{
    return 1.0 - step(0.0001, abs(leftValue - rightValue));
}

float CAMERA_OBSCURA_API_SpatialEvidence_LessEqual(float value, float upperBound)
{
    return 1.0 - step(0.0001, value - upperBound);
}

float CAMERA_OBSCURA_API_SpatialEvidence_Binary(float value)
{
    return saturate(CAMERA_OBSCURA_API_SpatialEvidence_Near(value, 0.0) + CAMERA_OBSCURA_API_SpatialEvidence_Near(value, 1.0));
}

float CAMERA_OBSCURA_API_SpatialEvidence_Whole(float value)
{
    return CAMERA_OBSCURA_API_SpatialEvidence_Near(value, floor(value + 0.5));
}

float CAMERA_OBSCURA_API_SpatialEvidence_Range(float value, float minimumValue, float maximumValue)
{
    return step(minimumValue - 0.0001, value) *
        CAMERA_OBSCURA_API_SpatialEvidence_LessEqual(value, maximumValue);
}

    CAMERA_OBSCURA_API_SpatialSupportEvidence CAMERA_OBSCURA_API_DefaultSpatialSupportEvidence()
    {CAMERA_OBSCURA_API_SpatialSupportEvidence evidence;
    evidence.valid = 0.0;
    evidence.source_valid = 0.0;
    evidence.center_valid = 0.0;
    evidence.center_applied = 0.0;
    evidence.center_flags_binary = 0.0;
    evidence.requested_neighbor_count = 0.0;
    evidence.available_neighbor_count = 0.0;
    evidence.accepted_neighbor_count = 0.0;
    evidence.count_values_valid = 0.0;
    evidence.count_partition_consistent = 0.0;
    evidence.weight_support_count = 0.0;
    evidence.support_count_consistent = 0.0;
    evidence.center_weight = 0.0;
    evidence.left_weight = 0.0;
    evidence.right_weight = 0.0;
    evidence.up_weight = 0.0;
    evidence.down_weight = 0.0;
    evidence.weights_valid = 0.0;
    evidence.expected_neighbor_weight_sum = 0.0;
    evidence.observed_neighbor_weight_sum = 0.0;
    evidence.neighbor_sum_consistent = 0.0;
    evidence.expected_total_weight = 0.0;
    evidence.observed_total_weight = 0.0;
    evidence.total_weight_consistent = 0.0;
    evidence.depth_support = 0.0;
    evidence.normal_support = 0.0;
    evidence.edge_support = 0.0;
    evidence.support_values_valid = 0.0;
    evidence.expected_resolved_r = 0.0;
    evidence.expected_resolved_g = 0.0;
    evidence.expected_resolved_b = 0.0;
    evidence.observed_resolved_r = 0.0;
    evidence.observed_resolved_g = 0.0;
    evidence.observed_resolved_b = 0.0;
    evidence.resolved_values_valid = 0.0;
    evidence.resolved_consistent = 0.0;
    evidence.expected_composite_r = 0.0;
    evidence.expected_composite_g = 0.0;
    evidence.expected_composite_b = 0.0;
    evidence.observed_composite_r = 0.0;
    evidence.observed_composite_g = 0.0;
    evidence.observed_composite_b = 0.0;
    evidence.composite_values_valid = 0.0;
    evidence.composite_consistent = 0.0;
    evidence.expected_state = 0.0;
    evidence.observed_state = 0.0;
    evidence.state_values_valid = 0.0;
    evidence.state_consistent = 0.0;
    evidence.center_stamp = 0.0;
    evidence.support_stamp = 0.0;
    evidence.resolve_stamp = 0.0;
    evidence.output_stamp = 0.0;
    evidence.generation_stamp = 0.0;
    evidence.source_stage_stamp = 0.0;
    return evidence;}

    CAMERA_OBSCURA_API_SpatialSupportEvidence CAMERA_OBSCURA_API_BuildSpatialSupportEvidence(
        float centerValid,float centerApplied,float requestedNeighborCount,float availableNeighborCount,float acceptedNeighborCount,
        float centerWeight,float leftWeight,float rightWeight,float upWeight,float downWeight,
        float expectedNeighborWeightSum,float observedNeighborWeightSum,float expectedTotalWeight,float observedTotalWeight,
        float depthSupport,float normalSupport,float edgeSupport,float3 expectedResolved,float3 observedResolved,float3 expectedComposite,float3 observedComposite,
        float expectedState,float observedState,float evidenceValid,float centerStamp,float supportStamp,float resolveStamp,float outputStamp,float generationStamp,float sourceStageStamp)
    {
        CAMERA_OBSCURA_API_SpatialSupportEvidence evidence=CAMERA_OBSCURA_API_DefaultSpatialSupportEvidence();
        float sourceValid=CAMERA_OBSCURA_API_SpatialEvidence_Binary(evidenceValid)*step(0.5,evidenceValid);
        float centerFlagsBinary=CAMERA_OBSCURA_API_SpatialEvidence_Binary(centerValid)*CAMERA_OBSCURA_API_SpatialEvidence_Binary(centerApplied);
        float countValuesValid=CAMERA_OBSCURA_API_SpatialEvidence_Whole(requestedNeighborCount)*CAMERA_OBSCURA_API_SpatialEvidence_Whole(availableNeighborCount)*CAMERA_OBSCURA_API_SpatialEvidence_Whole(acceptedNeighborCount)*
            CAMERA_OBSCURA_API_SpatialEvidence_Range(requestedNeighborCount,0.0,4.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(availableNeighborCount,0.0,4.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(acceptedNeighborCount,0.0,4.0);
        float countPartitionConsistent=CAMERA_OBSCURA_API_SpatialEvidence_LessEqual(availableNeighborCount,requestedNeighborCount)*CAMERA_OBSCURA_API_SpatialEvidence_LessEqual(acceptedNeighborCount,availableNeighborCount);
        float weightSupportCount=step(0.0001,leftWeight)+step(0.0001,rightWeight)+step(0.0001,upWeight)+step(0.0001,downWeight);
        float supportCountConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(weightSupportCount,acceptedNeighborCount);
        float weightsValid=CAMERA_OBSCURA_API_SpatialEvidence_Range(centerWeight,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(leftWeight,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(rightWeight,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(upWeight,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(downWeight,0.0,1.0);
        float actualNeighborSum=leftWeight+rightWeight+upWeight+downWeight;
        float neighborSumConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedNeighborWeightSum,actualNeighborSum)*CAMERA_OBSCURA_API_SpatialEvidence_Near(observedNeighborWeightSum,expectedNeighborWeightSum);
        float totalWeightConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedTotalWeight,centerWeight*centerApplied+actualNeighborSum)*CAMERA_OBSCURA_API_SpatialEvidence_Near(observedTotalWeight,expectedTotalWeight);
        float supportValuesValid=CAMERA_OBSCURA_API_SpatialEvidence_Range(depthSupport,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(normalSupport,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(edgeSupport,0.0,1.0);
        float resolvedValuesValid=CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedResolved.r,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedResolved.g,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedResolved.b,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedResolved.r,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedResolved.g,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedResolved.b,0.0,1.0);
        float resolvedConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedResolved.r,observedResolved.r)*CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedResolved.g,observedResolved.g)*CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedResolved.b,observedResolved.b);
        float compositeValuesValid=CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedComposite.r,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedComposite.g,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedComposite.b,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedComposite.r,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedComposite.g,0.0,1.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedComposite.b,0.0,1.0);
        float compositeConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedComposite.r,observedComposite.r)*CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedComposite.g,observedComposite.g)*CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedComposite.b,observedComposite.b);
        float stateValuesValid=CAMERA_OBSCURA_API_SpatialEvidence_Whole(expectedState)*CAMERA_OBSCURA_API_SpatialEvidence_Whole(observedState)*CAMERA_OBSCURA_API_SpatialEvidence_Range(expectedState,0.0,255.0)*CAMERA_OBSCURA_API_SpatialEvidence_Range(observedState,0.0,255.0);
        float stateConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near(expectedState,observedState);
        float emptyOwnershipConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near((1.0-centerValid)*(centerApplied+centerWeight+actualNeighborSum),0.0);
        float appliedOwnershipConsistent=CAMERA_OBSCURA_API_SpatialEvidence_Near((1.0-centerApplied)*(centerWeight+actualNeighborSum),0.0);
        float stampsValid=step(0.0001,centerStamp)*step(0.0001,supportStamp)*step(0.0001,resolveStamp)*step(0.0001,outputStamp)*step(0.0001,generationStamp)*step(0.0001,sourceStageStamp);

        evidence.source_valid=sourceValid;evidence.center_valid=centerValid;evidence.center_applied=centerApplied;evidence.center_flags_binary=centerFlagsBinary;
        evidence.requested_neighbor_count=requestedNeighborCount;evidence.available_neighbor_count=availableNeighborCount;evidence.accepted_neighbor_count=acceptedNeighborCount;evidence.count_values_valid=countValuesValid;evidence.count_partition_consistent=countPartitionConsistent;evidence.weight_support_count=weightSupportCount;evidence.support_count_consistent=supportCountConsistent;
        evidence.center_weight=centerWeight;evidence.left_weight=leftWeight;evidence.right_weight=rightWeight;evidence.up_weight=upWeight;evidence.down_weight=downWeight;evidence.weights_valid=weightsValid;
        evidence.expected_neighbor_weight_sum=expectedNeighborWeightSum;evidence.observed_neighbor_weight_sum=observedNeighborWeightSum;evidence.neighbor_sum_consistent=neighborSumConsistent;evidence.expected_total_weight=expectedTotalWeight;evidence.observed_total_weight=observedTotalWeight;evidence.total_weight_consistent=totalWeightConsistent;
        evidence.depth_support=depthSupport;evidence.normal_support=normalSupport;evidence.edge_support=edgeSupport;evidence.support_values_valid=supportValuesValid;
        evidence.expected_resolved_r=expectedResolved.r;evidence.expected_resolved_g=expectedResolved.g;evidence.expected_resolved_b=expectedResolved.b;evidence.observed_resolved_r=observedResolved.r;evidence.observed_resolved_g=observedResolved.g;evidence.observed_resolved_b=observedResolved.b;evidence.resolved_values_valid=resolvedValuesValid;evidence.resolved_consistent=resolvedConsistent;
        evidence.expected_composite_r=expectedComposite.r;evidence.expected_composite_g=expectedComposite.g;evidence.expected_composite_b=expectedComposite.b;evidence.observed_composite_r=observedComposite.r;evidence.observed_composite_g=observedComposite.g;evidence.observed_composite_b=observedComposite.b;evidence.composite_values_valid=compositeValuesValid;evidence.composite_consistent=compositeConsistent;
        evidence.expected_state=expectedState;evidence.observed_state=observedState;evidence.state_values_valid=stateValuesValid;evidence.state_consistent=stateConsistent;
        evidence.center_stamp=centerStamp;evidence.support_stamp=supportStamp;evidence.resolve_stamp=resolveStamp;evidence.output_stamp=outputStamp;evidence.generation_stamp=generationStamp;evidence.source_stage_stamp=sourceStageStamp;
        evidence.valid=sourceValid*centerFlagsBinary*countValuesValid*countPartitionConsistent*supportCountConsistent*weightsValid*neighborSumConsistent*totalWeightConsistent*supportValuesValid*resolvedValuesValid*resolvedConsistent*compositeValuesValid*compositeConsistent*stateValuesValid*stateConsistent*emptyOwnershipConsistent*appliedOwnershipConsistent*stampsValid;
        return evidence;
    }
    float CAMERA_OBSCURA_API_SpatialSupportClass(CAMERA_OBSCURA_API_SpatialSupportEvidence evidence)
    {float valid=step(0.5,evidence.valid);float center=step(0.5,evidence.center_valid*evidence.center_applied);float supported=step(0.5,evidence.accepted_neighbor_count);float validClass=center*((1.0-supported)*CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_CENTER+supported*CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_SUPPORTED);return lerp(CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_INVALID,validClass,valid);}
    #endif
