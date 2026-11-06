// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_SERVICES_FXH
#define CAMERA_OBSCURA_API_SERVICES_FXH

#include "CAMERA_OBSCURA_API_Common.fxh"
#include "../header/CAMERA_OBSCURA_EntryCapability.fxh"

CAMERA_OBSCURA_Capabilities CAMERA_OBSCURA_API_QueryCapabilities()
{
    return CAMERA_OBSCURA_QueryCapabilities();
}

CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildSurface(
    CAMERA_OBSCURA_API_Context context)
{
    return CAMERA_OBSCURA_BuildSurfaceGuide(context.uv);
}

float2 CAMERA_OBSCURA_API_SelectDirection(CAMERA_OBSCURA_API_Context context)
{
    return CAMERA_OBSCURA_SelectDirectionC0(
        floor(context.pixel),
        context.spatial_phase);
}

CAMERA_OBSCURA_RayRequest CAMERA_OBSCURA_API_DefaultRequest(float2 directionUv)
{
    return CAMERA_OBSCURA_DefaultRayRequest(directionUv);
}

CAMERA_OBSCURA_TraceControls CAMERA_OBSCURA_API_BuildControls(
    CAMERA_OBSCURA_RayRequest request)
{
    return CAMERA_OBSCURA_BuildTraceControls(request);
}

CAMERA_OBSCURA_Ray CAMERA_OBSCURA_API_BuildRay(
    CAMERA_OBSCURA_API_Context context,
    CAMERA_OBSCURA_SurfaceGuide surface,
    CAMERA_OBSCURA_RayRequest request,
    CAMERA_OBSCURA_TraceControls controls)
{
    return CAMERA_OBSCURA_BuildRayC0(
        context.uv,
        surface,
        request,
        controls);
}

#endif // CAMERA_OBSCURA_API_SERVICES_FXH
