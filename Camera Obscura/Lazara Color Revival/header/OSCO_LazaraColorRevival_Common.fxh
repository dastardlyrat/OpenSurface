// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef OSCO_LAZARA_COLOR_REVIVAL_COMMON_FXH
#define OSCO_LAZARA_COLOR_REVIVAL_COMMON_FXH

#ifndef OSCO_LCR_EXTERNAL_COLOR_ACCESS

texture2D OSCO_LCR_ColorTex : COLOR;

sampler2D OSCO_LCR_ColorSampler
{
    Texture = OSCO_LCR_ColorTex;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = POINT;
};

float2 OSCO_LCR_PixelSize()
{
    return float2(BUFFER_RCP_WIDTH, BUFFER_RCP_HEIGHT);
}

float2 OSCO_LCR_ClampUV(float2 uv)
{
    return clamp(uv, float2(0.0, 0.0), float2(1.0, 1.0));
}

float4 OSCO_LCR_LoadColor(float2 uv)
{
    return tex2Dlod(OSCO_LCR_ColorSampler, float4(OSCO_LCR_ClampUV(uv), 0.0, 0.0));
}

#endif

float OSCO_LCR_Luma(float3 color)
{
    return dot(color, float3(0.2126, 0.7152, 0.0722));
}

float OSCO_LCR_Chroma(float3 color)
{
    return max(abs(color.r - color.g), max(abs(color.g - color.b), abs(color.b - color.r)));
}

float OSCO_LCR_ChromaKeep(float chroma, float chromaFloor)
{
    float safeFloor = saturate(chromaFloor);
    return saturate((chroma - safeFloor) * rcp(max(1.0 - safeFloor, 0.000001)));
}

#endif
