// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_PROVIDERS_FXH
#define CAMERA_OBSCURA_API_PROVIDERS_FXH

#include "CAMERA_OBSCURA_API_Services.fxh"
#include "../header/CAMERA_OBSCURA_EntryTraversal.fxh"

CAMERA_OBSCURA_Hit CAMERA_OBSCURA_API_TraceDDA(
    CAMERA_OBSCURA_Ray ray,
    CAMERA_OBSCURA_TraceControls controls)
{
    return CAMERA_OBSCURA_RefineHit(
        ray,
        CAMERA_OBSCURA_TraceDDA(ray, controls),
        controls);
}

CAMERA_OBSCURA_Hit CAMERA_OBSCURA_API_TraceMarch(
    CAMERA_OBSCURA_Ray ray,
    CAMERA_OBSCURA_TraceControls controls)
{
    return CAMERA_OBSCURA_RefineHit(
        ray,
        CAMERA_OBSCURA_TraceMarch(ray, controls),
        controls);
}

#endif // CAMERA_OBSCURA_API_PROVIDERS_FXH
