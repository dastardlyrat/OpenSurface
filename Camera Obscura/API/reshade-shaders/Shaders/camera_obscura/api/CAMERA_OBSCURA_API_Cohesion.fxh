// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_COHESION_FXH
#define CAMERA_OBSCURA_API_COHESION_FXH

#include "CAMERA_OBSCURA_API_Providers.fxh"
#include "../header/CAMERA_OBSCURA_EntryTransport.fxh"

CAMERA_OBSCURA_DualHit CAMERA_OBSCURA_API_EvaluateDualHit(
    CAMERA_OBSCURA_Hit dda,
    CAMERA_OBSCURA_Hit march)
{
    return CAMERA_OBSCURA_EvaluateDualHit(dda, march);
}

CAMERA_OBSCURA_Contribution CAMERA_OBSCURA_API_BuildContribution(
    CAMERA_OBSCURA_API_Context context,
    CAMERA_OBSCURA_SurfaceGuide surface,
    CAMERA_OBSCURA_Hit hit)
{
    return CAMERA_OBSCURA_BuildContribution(
        context.uv,
        surface,
        hit);
}

CAMERA_OBSCURA_Fallback CAMERA_OBSCURA_API_DefaultFallback(
    CAMERA_OBSCURA_API_Context context,
    CAMERA_OBSCURA_SurfaceGuide surface)
{
    return CAMERA_OBSCURA_DefaultFallback(context.uv, surface);
}

float4 CAMERA_OBSCURA_API_Resolve(
    CAMERA_OBSCURA_DualHit dual,
    CAMERA_OBSCURA_Contribution ddaContribution,
    CAMERA_OBSCURA_Contribution marchContribution,
    CAMERA_OBSCURA_Fallback fallback)
{
    return CAMERA_OBSCURA_Resolve3(
        dual,
        ddaContribution,
        marchContribution,
        fallback);
}

float3 CAMERA_OBSCURA_API_Composite(
    CAMERA_OBSCURA_Fallback fallback,
    float4 resolved,
    float strength)
{
    return CAMERA_OBSCURA_Composite(
        fallback.rgb,
        resolved.rgb,
        resolved.a,
        strength);
}

#endif // CAMERA_OBSCURA_API_COHESION_FXH
