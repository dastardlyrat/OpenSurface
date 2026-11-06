// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TWIN_LANTERN_MARCH_PROOF_FXH
#define CAMERA_OBSCURA_API_TWIN_LANTERN_MARCH_PROOF_FXH

#include "CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh"
#include "../header/CAMERA_OBSCURA_EntryTraversalMarch.fxh"

CAMERA_OBSCURA_API_TwinLanternProviderEvidence
CAMERA_OBSCURA_API_BuildTwinLanternMarchEvidence(
    float2 uv,
    float directionIndex,
    float inputMode,
    float rayLengthPixels,
    float depthSlope,
    float frontBias,
    float backThickness)
{
    CAMERA_OBSCURA_TraceControls controls;
    CAMERA_OBSCURA_SurfaceGuide receiver;
    CAMERA_OBSCURA_Ray ray = CAMERA_OBSCURA_API_BuildTL45Ray(
        uv,
        directionIndex,
        inputMode,
        CAMERA_OBSCURA_MARCH_MAX_STEPS,
        rayLengthPixels,
        depthSlope,
        frontBias,
        backThickness,
        controls,
        receiver);
    CAMERA_OBSCURA_Hit coarse = CAMERA_OBSCURA_TraceMarch(ray, controls);
    CAMERA_OBSCURA_Hit refined = CAMERA_OBSCURA_RefineHit(
        ray,
        coarse,
        controls);
    return CAMERA_OBSCURA_API_BuildTL45Evidence(
        ray,
        controls,
        receiver,
        coarse,
        refined,
        CAMERA_OBSCURA_BACKEND_MARCH);
}

#endif // CAMERA_OBSCURA_API_TWIN_LANTERN_MARCH_PROOF_FXH
