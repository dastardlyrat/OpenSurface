// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_ENTRY_TRANSPORT_FXH
#define CAMERA_OBSCURA_ENTRY_TRANSPORT_FXH

#include "CAMERA_OBSCURA_EntryTraversal.fxh"

CAMERA_OBSCURA_DualHit CAMERA_OBSCURA_EvaluateDualHit(
    CAMERA_OBSCURA_Hit dda,
    CAMERA_OBSCURA_Hit march)
{
    CAMERA_OBSCURA_DualHit dual;
    dual.dda_hit = dda.hit;
    dual.dda_confidence = dda.confidence;
    dual.dda_reason = dda.reason;
    dual.march_hit = march.hit;
    dual.march_confidence = march.confidence;
    dual.march_reason = march.reason;

    if (dda.hit > 0.5 && march.hit > 0.5)
    {
        float2 pixelSize = max(CAMERA_OBSCURA_PixelSize(), float2(0.000001, 0.000001));
        float uvDeltaPixels = length((dda.uv - march.uv) / pixelSize);
        dual.uv_agreement = saturate(1.0 - uvDeltaPixels / 8.0);
        dual.depth_agreement = saturate(
            1.0 - abs(dda.scene_z - march.scene_z) * 64.0);
        dual.distance_agreement = saturate(
            1.0 - abs(dda.ray_t - march.ray_t) *
            CAMERA_OBSCURA_SafeRcp(max(dda.ray_t, march.ray_t) + 1.0, 0.0));
    }
    else
    {
        dual.uv_agreement = 0.0;
        dual.depth_agreement = 0.0;
        dual.distance_agreement = 0.0;
    }

    dual.conflict = saturate(1.0 - min(
        dual.uv_agreement,
        min(dual.depth_agreement, dual.distance_agreement)));
    dual.combined_confidence = saturate(
        max(dda.confidence, march.confidence) *
        (1.0 - dual.conflict * 0.35));
    return dual;
}

CAMERA_OBSCURA_Contribution CAMERA_OBSCURA_BuildContribution(
    float2 receiverUv,
    CAMERA_OBSCURA_SurfaceGuide receiver,
    CAMERA_OBSCURA_Hit hit)
{
    CAMERA_OBSCURA_Contribution contribution;
    contribution.valid = hit.hit * receiver.valid;
    contribution.donor_rgb = float3(0.0, 0.0, 0.0);
    contribution.indirect_rgb = float3(0.0, 0.0, 0.0);
    contribution.weight = 0.0;
    contribution.coverage = 0.0;
    contribution.distance_weight = 0.0;
    contribution.receiver_facing = 0.0;
    contribution.donor_facing = 0.0;
    contribution.normal_compatibility = 0.0;
    contribution.confidence = 0.0;
    contribution.backend = hit.backend;

    if (contribution.valid < 0.5)
    {
        return contribution;
    }

    float2 pixelSize = max(CAMERA_OBSCURA_PixelSize(), float2(0.000001, 0.000001));
    float marchBackend =
        1.0 - step(0.5, abs(hit.backend - CAMERA_OBSCURA_BACKEND_MARCH));
    float3 donor = CAMERA_OBSCURA_LoadColor(hit.uv);
    float3 marchDonorFiltered = (
        donor +
        CAMERA_OBSCURA_LoadColor(hit.uv + float2(0.0, pixelSize.y)) +
        CAMERA_OBSCURA_LoadColor(hit.uv - float2(0.0, pixelSize.y))) *
        0.33333333;
    donor = lerp(
        donor,
        marchDonorFiltered,
        marchBackend * saturate(CAMERA_OBSCURA_MARCH_DONOR_PREFILTER_STRENGTH));
    float3 source = CAMERA_OBSCURA_LoadColor(receiverUv);
    float donorLuma = CAMERA_OBSCURA_Luma(donor);
    float sourceLuma = CAMERA_OBSCURA_Luma(source);
    float distancePixels = length((hit.uv - receiverUv) / pixelSize);
    float coverage = saturate(1.0 - receiver.edge_risk);
    float distanceWeight = saturate(1.0 - distancePixels / 48.0);
    float receiverFacing = saturate(receiver.normal.z);
    float donorFacing = saturate(1.0 - abs(hit.delta) * 24.0);
    float normalCompatibility = saturate(1.0 - receiver.edge_risk * 0.5);
    float weight = saturate(
        hit.confidence *
        coverage *
        distanceWeight *
        max(receiverFacing, 0.25));
    float3 indirect = saturate(
        donor *
        max(donorLuma - sourceLuma * 0.35, 0.0) *
        (0.6 + 0.4 * donorFacing));

    contribution.donor_rgb = donor;
    contribution.indirect_rgb = indirect;
    contribution.weight = weight;
    contribution.coverage = coverage;
    contribution.distance_weight = distanceWeight;
    contribution.receiver_facing = receiverFacing;
    contribution.donor_facing = donorFacing;
    contribution.normal_compatibility = normalCompatibility;
    contribution.confidence = saturate(hit.confidence * coverage);
    return contribution;
}

CAMERA_OBSCURA_Fallback CAMERA_OBSCURA_DefaultFallback(
    float2 uv,
    CAMERA_OBSCURA_SurfaceGuide receiver)
{
    CAMERA_OBSCURA_Fallback fallback;
    fallback.rgb = CAMERA_OBSCURA_LoadColor(uv);
    fallback.confidence = receiver.valid;
    fallback.class_id = receiver.edge_risk;
    return fallback;
}

float4 CAMERA_OBSCURA_EncodeRaw(CAMERA_OBSCURA_Contribution contribution)
{
    return float4(
        saturate(contribution.indirect_rgb),
        saturate(contribution.weight));
}

float4 CAMERA_OBSCURA_Resolve3(
    CAMERA_OBSCURA_DualHit dual,
    CAMERA_OBSCURA_Contribution ddaContribution,
    CAMERA_OBSCURA_Contribution marchContribution,
    CAMERA_OBSCURA_Fallback fallback)
{
    float ddaWeight = ddaContribution.weight * ddaContribution.valid;
    float marchWeight = marchContribution.weight * marchContribution.valid;
    float totalWeight = ddaWeight + marchWeight;
    float normalizeWeight = CAMERA_OBSCURA_SafeRcp(max(totalWeight, 0.000001), 0.0);
    float3 indirect =
        totalWeight > 0.0 ?
        (ddaContribution.indirect_rgb * ddaWeight +
            marchContribution.indirect_rgb * marchWeight) * normalizeWeight :
        float3(0.0, 0.0, 0.0);
    float confidence = saturate(
        max(dual.combined_confidence,
            max(ddaContribution.confidence, marchContribution.confidence)) *
        fallback.confidence);
    return float4(saturate(indirect), confidence);
}

float3 CAMERA_OBSCURA_Composite(
    float3 source,
    float3 indirect,
    float confidence,
    float strength)
{
    return saturate(source + indirect * saturate(confidence) * saturate(strength));
}

#endif // CAMERA_OBSCURA_ENTRY_TRANSPORT_FXH
