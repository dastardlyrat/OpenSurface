// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_DEBUG_FXH
#define CAMERA_OBSCURA_API_DEBUG_FXH

#include "CAMERA_OBSCURA_API_Cohesion.fxh"
#include "../header/CAMERA_OBSCURA_AtomicDebug.fxh"

float3 CAMERA_OBSCURA_API_DebugView(
    float view,
    float3 source,
    float3 composite,
    CAMERA_OBSCURA_Hit dda,
    CAMERA_OBSCURA_Hit march,
    CAMERA_OBSCURA_DualHit dual,
    CAMERA_OBSCURA_Contribution ddaContribution,
    CAMERA_OBSCURA_Contribution marchContribution)
{
    return CAMERA_OBSCURA_DebugView(
        view,
        source,
        composite,
        dda,
        march,
        dual,
        ddaContribution,
        marchContribution);
}

#endif // CAMERA_OBSCURA_API_DEBUG_FXH
