// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TWIN_LANTERN_DETAIL_TARGET_FXH
#define CAMERA_OBSCURA_API_TWIN_LANTERN_DETAIL_TARGET_FXH

#include "CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh"

struct CAMERA_OBSCURA_API_TL08DetailTargetEvidence
{
    float detail_energy;
    float detail_gate;
    float surface_support;
    float weakest_surface_support;
    float boundary_safety;
    float transport_change;
    float transport_gate;
    float target_score;
    float rejected_score;
};

CAMERA_OBSCURA_API_TL08DetailTargetEvidence
CAMERA_OBSCURA_API_DefaultTL08DetailTargetEvidence()
{
    CAMERA_OBSCURA_API_TL08DetailTargetEvidence evidence;
    evidence.detail_energy = 0.0;
    evidence.detail_gate = 0.0;
    evidence.surface_support = 0.0;
    evidence.weakest_surface_support = 0.0;
    evidence.boundary_safety = 0.0;
    evidence.transport_change = 0.0;
    evidence.transport_gate = 0.0;
    evidence.target_score = 0.0;
    evidence.rejected_score = 0.0;
    return evidence;
}

float CAMERA_OBSCURA_API_TL08SmoothGate(
    float value,
    float startValue,
    float fullValue)
{
    float width = max(fullValue - startValue, 0.000001);
    float position = saturate((value - startValue) / width);
    return position * position * (3.0 - 2.0 * position);
}

CAMERA_OBSCURA_API_TL08DetailTargetEvidence
CAMERA_OBSCURA_API_BuildTL08DetailTarget(
    float3 centerSource,
    float3 negativeXSource,
    float3 positiveXSource,
    float3 negativeYSource,
    float3 positiveYSource,
    float negativeXAvailable,
    float positiveXAvailable,
    float negativeYAvailable,
    float positiveYAvailable,
    float negativeXSurface,
    float positiveXSurface,
    float negativeYSurface,
    float positiveYSurface,
    float3 baselineSignal,
    float3 stabilizedSignal,
    float detailStart,
    float detailFull,
    float changeStart,
    float changeFull)
{
    CAMERA_OBSCURA_API_TL08DetailTargetEvidence evidence =
        CAMERA_OBSCURA_API_DefaultTL08DetailTargetEvidence();
    float negativeXCoverage = saturate(negativeXAvailable);
    float positiveXCoverage = saturate(positiveXAvailable);
    float negativeYCoverage = saturate(negativeYAvailable);
    float positiveYCoverage = saturate(positiveYAvailable);
    float negativeXWeight = saturate(negativeXSurface) * negativeXCoverage;
    float positiveXWeight = saturate(positiveXSurface) * positiveXCoverage;
    float negativeYWeight = saturate(negativeYSurface) * negativeYCoverage;
    float positiveYWeight = saturate(positiveYSurface) * positiveYCoverage;
    float availableCount =
        negativeXCoverage + positiveXCoverage +
        negativeYCoverage + positiveYCoverage;
    float supportSum =
        negativeXWeight + positiveXWeight +
        negativeYWeight + positiveYWeight;
    float3 neighborSum =
        negativeXSource * negativeXWeight +
        positiveXSource * positiveXWeight +
        negativeYSource * negativeYWeight +
        positiveYSource * positiveYWeight;
    float hasSupport = step(0.000001, supportSum);
    float3 neighborMean = lerp(
        centerSource,
        neighborSum * CAMERA_OBSCURA_SafeRcp(supportSum, 0.0),
        hasSupport);
    float detailEnergy = abs(
        CAMERA_OBSCURA_Luma(centerSource) -
        CAMERA_OBSCURA_Luma(neighborMean));
    float detailGate = CAMERA_OBSCURA_API_TL08SmoothGate(
        detailEnergy, detailStart, detailFull);
    float hasNeighbors = step(0.5, availableCount);
    float surfaceSupport = saturate(
        supportSum * CAMERA_OBSCURA_SafeRcp(availableCount, 0.0)) *
        hasNeighbors;
    float weakestSurface = min(
        min(
            lerp(1.0, negativeXWeight, negativeXCoverage),
            lerp(1.0, positiveXWeight, positiveXCoverage)),
        min(
            lerp(1.0, negativeYWeight, negativeYCoverage),
            lerp(1.0, positiveYWeight, positiveYCoverage))) *
        hasNeighbors;
    float boundarySafety = saturate(weakestSurface);
    float transportChange = CAMERA_OBSCURA_Luma(
        abs(stabilizedSignal - baselineSignal));
    float transportGate = CAMERA_OBSCURA_API_TL08SmoothGate(
        transportChange, changeStart, changeFull);
    float detailInstability = detailGate * transportGate;
    float openSurfaceAuthority = surfaceSupport * boundarySafety;

    evidence.detail_energy = detailEnergy;
    evidence.detail_gate = detailGate;
    evidence.surface_support = surfaceSupport;
    evidence.weakest_surface_support = weakestSurface;
    evidence.boundary_safety = boundarySafety;
    evidence.transport_change = transportChange;
    evidence.transport_gate = transportGate;
    evidence.target_score = saturate(
        detailInstability * openSurfaceAuthority);
    evidence.rejected_score = saturate(
        detailInstability * (1.0 - openSurfaceAuthority));
    return evidence;
}

#endif // CAMERA_OBSCURA_API_TWIN_LANTERN_DETAIL_TARGET_FXH
