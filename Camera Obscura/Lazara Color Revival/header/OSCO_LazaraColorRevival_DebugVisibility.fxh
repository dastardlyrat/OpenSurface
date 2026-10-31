// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef OSCO_LAZARA_COLOR_REVIVAL_DEBUG_VISIBILITY_FXH
#define OSCO_LAZARA_COLOR_REVIVAL_DEBUG_VISIBILITY_FXH

float OSCO_LCR_SafePowNonNegative(float value, float exponent)
{
    return pow(max(value, 0.0), max(exponent, 0.000001));
}

float3 OSCO_LCR_DebugVisibilityColor(
    float3 color,
    float exposure,
    float bias,
    float contrast,
    float gammaValue,
    float floorValue)
{
    float3 adjusted = saturate(color * max(exposure, 0.0) + bias.xxx);
    adjusted = saturate((adjusted - 0.5.xxx) * max(contrast, 0.0) + 0.5.xxx);
    adjusted = float3(
        OSCO_LCR_SafePowNonNegative(adjusted.r, gammaValue),
        OSCO_LCR_SafePowNonNegative(adjusted.g, gammaValue),
        OSCO_LCR_SafePowNonNegative(adjusted.b, gammaValue));
    return max(adjusted, saturate(floorValue).xxx);
}

float3 OSCO_LCR_DebugVisibilityHeat(float value)
{
    float position = saturate(value);
    float3 cold = float3(0.02, 0.05, 0.35);
    float3 middle = float3(0.05, 0.95, 0.20);
    float3 hot = float3(1.00, 0.18, 0.02);
    float3 lower = lerp(cold, middle, saturate(position * 2.0));
    float3 upper = lerp(middle, hot, saturate((position - 0.5) * 2.0));
    return (position < 0.5) ? lower : upper;
}

float3 OSCO_LCR_DebugVisibilityPost(
    float3 color,
    int postMode,
    float exposure,
    float bias,
    float contrast,
    float gammaValue,
    float floorValue,
    float thresholdValue)
{
    float3 adjusted = OSCO_LCR_DebugVisibilityColor(
        color,
        exposure,
        bias,
        contrast,
        gammaValue,
        floorValue);
    float luma = dot(adjusted, float3(0.2126, 0.7152, 0.0722));
    float thresholdMask = (luma >= saturate(thresholdValue)) ? 1.0 : 0.0;
    float3 result = adjusted;

    if (postMode == 1)
    {
        result = max(adjusted, saturate(floorValue).xxx);
    }
    else if (postMode == 2)
    {
        result = OSCO_LCR_DebugVisibilityHeat(luma);
    }
    else if (postMode == 3)
    {
        result = thresholdMask.xxx;
    }
    else if (postMode == 4)
    {
        result = 1.0.xxx - adjusted;
    }

    return result;
}

#endif
