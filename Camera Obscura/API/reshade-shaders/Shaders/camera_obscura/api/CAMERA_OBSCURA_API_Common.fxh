// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_COMMON_FXH
#define CAMERA_OBSCURA_API_COMMON_FXH

#include "../header/CAMERA_OBSCURA_AtomicCommon.fxh"

#define CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MAJOR 1
#define CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MINOR 0
#define CAMERA_OBSCURA_API_SCAFFOLD_VERSION_PATCH 0

#define CAMERA_OBSCURA_API_STAGE_TRUTH 1
#define CAMERA_OBSCURA_API_STAGE_PROVIDERS 2
#define CAMERA_OBSCURA_API_STAGE_COHESION 3

struct CAMERA_OBSCURA_API_Context
{
    float2 uv;
    float2 pixel;
    float spatial_phase;
    float stage;
};

CAMERA_OBSCURA_API_Context CAMERA_OBSCURA_API_MakeContext(
    float2 uv,
    float2 pixel,
    float spatialPhase,
    float stage)
{
    CAMERA_OBSCURA_API_Context context;
    context.uv = CAMERA_OBSCURA_SaturateUV(uv);
    context.pixel = pixel;
    context.spatial_phase = spatialPhase;
    context.stage = stage;
    return context;
}

float CAMERA_OBSCURA_API_VersionCode()
{
    return
        (float)CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MAJOR * 10000.0 +
        (float)CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MINOR * 100.0 +
        (float)CAMERA_OBSCURA_API_SCAFFOLD_VERSION_PATCH;
}

#endif // CAMERA_OBSCURA_API_COMMON_FXH
