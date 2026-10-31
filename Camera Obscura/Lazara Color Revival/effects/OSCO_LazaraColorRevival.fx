#include "ReShade.fxh"
#include "../header/OSCO_LazaraColorRevival_Common.fxh"
#include "../header/OSCO_LazaraColorRevival_DebugVisibility.fxh"

// Source-derived color recovery with neutral protection, local palette harmony,
// and muddy-region-only chromatic separation.

uniform int OSCO_LCR_Enable
< ui_type = "combo"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Enable Color Revival"; ui_items = "Off\0On\0"; ui_tooltip = "Master enable for the compact muddy-scene color revival filter."; > = 1;

uniform int OSCO_LCR_InvertColorRecovery
< ui_type = "combo"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Invert Color Recovery"; ui_items = "Recover Color\0Degrade Color\0"; ui_tooltip = "Recover Color: applies source-derived color correction.\nDegrade Color: disables recovery, removes admitted chroma, and preserves source luma.\nThis changes the final effect output; it is not a diagnostic display mode."; > = 0;

uniform float OSCO_LCR_ColorStrength
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Color Strength"; ui_min = 0.00; ui_max = 2.60; ui_step = 0.01; ui_tooltip = "Overall source-derived color invigoration strength. It increases the winning observed hue family without assigning a fixed color."; > = 1.45;

uniform float OSCO_LCR_MutedColorLift
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Muted Color Lift"; ui_min = 0.00; ui_max = 2.60; ui_step = 0.01; ui_tooltip = "Extra chroma recovery for colors that are present but look washed out or muddy."; > = 1.75;

uniform float OSCO_LCR_Vibrancy
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Dominant Hue Vibrancy"; ui_min = 0.00; ui_max = 3.00; ui_step = 0.01; ui_tooltip = "Moves an observed source or locally dominant hue toward a more vivid luma-preserving version. Green receives this lift only when green evidence dominates."; > = 1.65;

uniform float OSCO_LCR_PaletteMigration
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Muted Hue Migration"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Allows a weak but non-neutral source hue to move slightly toward the strongest nearby observed hue. Fully neutral surfaces remain protected."; > = 0.20;

uniform float OSCO_LCR_ToneContrast
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Tone Contrast"; ui_min = 0.50; ui_max = 2.10; ui_step = 0.01; ui_tooltip = "Small tone-shape push before color revival so muddy scenes do not stay flat."; > = 1.14;

uniform float OSCO_LCR_Warmth
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Manual Temperature Bias"; ui_min = -1.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Optional artistic override: negative cools and positive warms. Zero is neutral and leaves automatic promotion entirely source- and harmony-derived."; > = 0.00;

uniform float OSCO_LCR_LiveSchemeBoost
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Harmony Boost"; ui_min = 0.00; ui_max = 3.20; ui_step = 0.01; ui_tooltip = "Strengthens existing colors when their hue has an analogous, complementary, triadic, or split-complement relationship with the nearby chromatic palette. No hue family is preferred."; > = 1.55;

uniform float OSCO_LCR_SchemePull
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Harmony Guidance"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Controls how strongly local color relationships guide recovery strength. It does not rotate or replace the source hue."; > = 0.24;

uniform float OSCO_LCR_HueWidth
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Harmony Tolerance"; ui_min = 0.02; ui_max = 0.25; ui_step = 0.005; ui_tooltip = "Tolerance around analogous, complementary, triadic, and split-complement relationships in the local palette."; > = 0.09;

uniform float OSCO_LCR_HighlightProtect
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Highlight Protect"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Reduces the effect in bright highlights so revived color does not turn into glow wash."; > = 0.60;

uniform float OSCO_LCR_MudSaturationCeiling
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Mud Saturation Ceiling"; ui_min = 0.02; ui_max = 0.50; ui_step = 0.005; ui_tooltip = "Upper saturation limit for classifying a region as muddy. Lower values target only flatter neutrals; higher values reach further into dirty browns."; > = 0.18;

uniform float OSCO_LCR_MudContrastCeiling
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Mud Contrast Ceiling"; ui_min = 0.01; ui_max = 0.30; ui_step = 0.005; ui_tooltip = "Upper local-contrast limit for muddy-region detection. Lower values keep the chromatic split off high-detail edges."; > = 0.09;

uniform float OSCO_LCR_MudMidpoint
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Mud Midpoint"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Brightness center where muddy-region treatment is favored most."; > = 0.46;

uniform float OSCO_LCR_MudMidWidth
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Mud Mid Width"; ui_min = 0.05; ui_max = 0.60; ui_step = 0.01; ui_tooltip = "Brightness width around the muddy midpoint that still qualifies for the muddy-region treatment."; > = 0.28;

uniform float OSCO_LCR_ChromaticSplitPixels
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Chromatic Split Pixels"; ui_min = 0.00; ui_max = 4.00; ui_step = 0.01; ui_tooltip = "How far the muddy-only chromatic split may separate the red and blue samples."; > = 0.85;

uniform float OSCO_LCR_ChromaticSplitBlend
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Chromatic Split Blend"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Blend amount of the muddy-only chromatic aberration accent."; > = 0.40;

uniform int OSCO_LCR_View
< ui_type = "combo"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "View"; ui_items = "Final Composite\0Color Result\0Mud Mask\0Invigorate Mask\0Local Contrast\0Chromatic Split Only\0Local Palette\0Harmony Support\0Vibrancy Drive\0Hue Migration\0"; ui_tooltip = "Shows the selected recovery or degradation result, masks, source-derived palette, harmony support, dominant-hue vibrancy, or muted-hue migration."; > = 0;

uniform int OSCO_LCR_DebugPostMode
< ui_type = "combo"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Visibility Mode"; ui_items = "Normal Adjusted\0Lift Floor\0Heat Luma\0Threshold Mask\0Invert\0"; ui_tooltip = "Post-processes non-final diagnostics for readability only."; > = 0;

uniform float OSCO_LCR_DebugExposure
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Exposure"; ui_min = 0.00; ui_max = 8.00; ui_step = 0.01; ui_tooltip = "Brightens weak diagnostics before gamma."; > = 1.00;

uniform float OSCO_LCR_DebugBias
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Bias"; ui_min = -1.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Adds brightness before contrast and gamma for diagnostics."; > = 0.00;

uniform float OSCO_LCR_DebugContrast
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Contrast"; ui_min = 0.00; ui_max = 8.00; ui_step = 0.01; ui_tooltip = "Stretches diagnostics around mid-gray."; > = 1.00;

uniform float OSCO_LCR_DebugGamma
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Gamma"; ui_min = 0.10; ui_max = 4.00; ui_step = 0.01; ui_tooltip = "Curves diagnostics after exposure and contrast."; > = 1.00;

uniform float OSCO_LCR_DebugFloor
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Floor"; ui_min = 0.00; ui_max = 0.50; ui_step = 0.005; ui_tooltip = "Minimum visible floor for diagnostics."; > = 0.00;

uniform float OSCO_LCR_DebugThreshold
< ui_type = "slider"; ui_category = "OpenSurface / Camera Obscura / Lazara Color Revival"; ui_label = "Debug Threshold"; ui_min = 0.00; ui_max = 1.00; ui_step = 0.01; ui_tooltip = "Threshold used only by Threshold Mask mode."; > = 0.50;

float OSCO_LCR_BellMask(float value, float pivot, float width)
{
    float safeWidth = max(width, 0.0001);
    return saturate(1.0 - abs(value - pivot) * rcp(safeWidth));
}

float3 OSCO_LCR_PeakLimit(float3 color, float start, float end)
{
    float3 safeColor = max(color, 0.0.xxx);
    float peak = max(safeColor.r, max(safeColor.g, safeColor.b));
    float safeRange = max(end - start, 0.0001);
    float compression = saturate((peak - start) * rcp(safeRange));
    float targetScale = (peak > 0.000001) ? min(1.0, rcp(peak)) : 1.0;
    return saturate(safeColor * lerp(1.0, targetScale, compression));
}

float OSCO_LCR_PaletteWeight(float3 color, float centerLuma)
{
    float chroma = OSCO_LCR_Chroma(color);
    float lumaAgreement = 1.0 - saturate(
        abs(OSCO_LCR_Luma(color) - centerLuma) * rcp(0.18));
    return chroma * (0.20 + lumaAgreement * 0.80);
}

void OSCO_LCR_LocalContext(
    float2 uv,
    float2 pixelSize,
    float3 sourceColor,
    out float localContrast,
    out float3 paletteColor,
    out float paletteStrength)
{
    float3 leftColor = OSCO_LCR_LoadColor(
        uv + float2(-pixelSize.x, 0.0)).rgb;
    float3 rightColor = OSCO_LCR_LoadColor(
        uv + float2(pixelSize.x, 0.0)).rgb;
    float3 upColor = OSCO_LCR_LoadColor(
        uv + float2(0.0, -pixelSize.y)).rgb;
    float3 downColor = OSCO_LCR_LoadColor(
        uv + float2(0.0, pixelSize.y)).rgb;

    float centerLuma = OSCO_LCR_Luma(sourceColor);
    float leftLuma = OSCO_LCR_Luma(leftColor);
    float rightLuma = OSCO_LCR_Luma(rightColor);
    float upLuma = OSCO_LCR_Luma(upColor);
    float downLuma = OSCO_LCR_Luma(downColor);

    float horizontal = max(
        abs(centerLuma - leftLuma),
        abs(centerLuma - rightLuma));
    float vertical = max(
        abs(centerLuma - upLuma),
        abs(centerLuma - downLuma));
    localContrast = max(horizontal, vertical);

    float leftWeight = OSCO_LCR_PaletteWeight(leftColor, centerLuma);
    float rightWeight = OSCO_LCR_PaletteWeight(rightColor, centerLuma);
    float upWeight = OSCO_LCR_PaletteWeight(upColor, centerLuma);
    float downWeight = OSCO_LCR_PaletteWeight(downColor, centerLuma);

    float bestWeight = leftWeight;
    float3 strongestColor = leftColor;
    if (rightWeight > bestWeight)
    {
        bestWeight = rightWeight;
        strongestColor = rightColor;
    }
    if (upWeight > bestWeight)
    {
        bestWeight = upWeight;
        strongestColor = upColor;
    }
    if (downWeight > bestWeight)
    {
        bestWeight = downWeight;
        strongestColor = downColor;
    }

    paletteColor = sourceColor;
    if (bestWeight > 0.000001)
    {
        paletteColor = strongestColor;
    }
    paletteColor = saturate(paletteColor);
    paletteStrength = saturate(bestWeight * 3.0);
}

float OSCO_LCR_HighlightProtection(float luma)
{
    float highlightMask = smoothstep(0.68, 0.98, luma);
    return lerp(1.0, 1.0 - highlightMask, saturate(OSCO_LCR_HighlightProtect));
}

float3 OSCO_LCR_RGBtoHSV(float3 c)
{
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = (c.g < c.b) ? float4(c.bg, K.wz) : float4(c.gb, K.xy);
    float4 q = (c.r < p.x) ? float4(p.xyw, c.r) : float4(c.r, p.yzx);
    float d = q.x - min(q.w, q.y);
    float e = 0.000010;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float3 OSCO_LCR_HSVtoRGB(float3 hsv)
{
    float3 p = abs(frac(hsv.xxx + float3(0.0, 2.0 / 3.0, 1.0 / 3.0)) * 6.0 - 3.0);
    return hsv.z * lerp(1.0.xxx, saturate(p - 1.0), hsv.y);
}

float OSCO_LCR_HueDistance(float a, float b)
{
    float d = abs(frac(a - b + 0.5) - 0.5);
    return min(d, 1.0 - d);
}

float OSCO_LCR_HueLerp(float sourceHue, float targetHue, float amount)
{
    float delta = frac(targetHue - sourceHue + 0.5) - 0.5;
    return frac(sourceHue + delta * saturate(amount) + 1.0);
}

float OSCO_LCR_HueEvidence(float3 color)
{
    float3 hsv = OSCO_LCR_RGBtoHSV(color);
    float chroma = OSCO_LCR_Chroma(color);
    return saturate(hsv.y * 1.20 + chroma * 0.80);
}

float OSCO_LCR_PaletteDominance(
    float3 sourceColor,
    float3 paletteColor,
    float paletteStrength)
{
    float sourceEvidence = OSCO_LCR_HueEvidence(sourceColor);
    float paletteEvidence =
        OSCO_LCR_HueEvidence(paletteColor) *
        saturate(paletteStrength);
    return saturate(
        (paletteEvidence - sourceEvidence + 0.08) * 4.0);
}

float OSCO_LCR_HueMigrationAmount(
    float3 sourceColor,
    float3 paletteColor,
    float paletteStrength)
{
    float3 sourceHSV = OSCO_LCR_RGBtoHSV(sourceColor);
    float weakColorSeed =
        smoothstep(0.015, 0.12, sourceHSV.y) *
        (1.0 - smoothstep(0.48, 0.78, sourceHSV.y));
    float paletteDominance = OSCO_LCR_PaletteDominance(
        sourceColor,
        paletteColor,
        paletteStrength);
    return saturate(
        max(OSCO_LCR_PaletteMigration, 0.0) *
        weakColorSeed *
        paletteDominance);
}

float OSCO_LCR_VibrancyDrive(
    float3 sourceColor,
    float3 paletteColor,
    float paletteStrength,
    float harmonySupport)
{
    float sourceEvidence = OSCO_LCR_HueEvidence(sourceColor);
    float paletteEvidence =
        OSCO_LCR_HueEvidence(paletteColor) *
        saturate(paletteStrength);
    float dominantEvidence = max(sourceEvidence, paletteEvidence);
    return saturate(
        max(OSCO_LCR_Vibrancy, 0.0) *
        0.42 *
        (0.30 + dominantEvidence * 0.50 + saturate(harmonySupport) * 0.35));
}

float OSCO_LCR_HarmonyBand(
    float hueDistance,
    float relationshipCenter,
    float width,
    float feather)
{
    return 1.0 - smoothstep(
        width,
        width + feather,
        abs(hueDistance - relationshipCenter));
}

float OSCO_LCR_ColorTheorySupport(
    float3 sourceColor,
    float3 paletteColor,
    float paletteStrength)
{
    float3 sourceHSV = OSCO_LCR_RGBtoHSV(sourceColor);
    float3 paletteHSV = OSCO_LCR_RGBtoHSV(paletteColor);
    float distance = OSCO_LCR_HueDistance(
        sourceHSV.x,
        paletteHSV.x);
    float width = max(OSCO_LCR_HueWidth * 0.45, 0.01);
    float feather = max(width * 0.75, 0.01);

    float analogous = OSCO_LCR_HarmonyBand(
        distance, 0.0, width, feather);
    float triadic = OSCO_LCR_HarmonyBand(
        distance, 1.0 / 3.0, width, feather);
    float splitComplement = OSCO_LCR_HarmonyBand(
        distance, 5.0 / 12.0, width, feather);
    float complementary = OSCO_LCR_HarmonyBand(
        distance, 0.5, width, feather);

    float relationship = max(
        analogous,
        max(
            complementary * 0.95,
            max(triadic * 0.85, splitComplement * 0.75)));
    float sourceHueTrust = saturate(sourceHSV.y * 1.50);
    float paletteHueTrust = saturate(
        paletteHSV.y * max(paletteStrength, 0.0) * 1.50);
    return saturate(
        relationship * sourceHueTrust * paletteHueTrust);
}

float3 OSCO_LCR_TonePreserve(float3 color)
{
    float luma = OSCO_LCR_Luma(color);
    float shapedLuma = saturate((luma - 0.5) * max(OSCO_LCR_ToneContrast, 0.0) + 0.5);
    return OSCO_LCR_PeakLimit(shapedLuma.xxx + (color - luma.xxx), 0.84, 1.12);
}

float3 OSCO_LCR_WarmCool(float3 color)
{
    float amount = OSCO_LCR_Warmth;
    float3 tinted = color;

    if (amount >= 0.0)
    {
        tinted *= float3(1.0 + amount * 0.10, 1.0 + amount * 0.03, 1.0 - amount * 0.10);
    }
    else
    {
        float cool = -amount;
        tinted *= float3(1.0 - cool * 0.10, 1.0 + cool * 0.02, 1.0 + cool * 0.12);
    }

    float sourceLuma = OSCO_LCR_Luma(color);
    float tintedLuma = max(OSCO_LCR_Luma(tinted), 0.000001);
    float preserve = lerp(1.0, sourceLuma * rcp(tintedLuma), 0.65);
    return OSCO_LCR_PeakLimit(tinted * preserve, 0.86, 1.10);
}

float3 OSCO_LCR_Revive(
    float3 sourceColor,
    float recoveryHue,
    float sourceHarmonySupport,
    float sourceVibrancyDrive,
    float invigorateMask,
    float protection)
{
    float3 toned = OSCO_LCR_TonePreserve(sourceColor);
    float safeInvigorate = saturate(invigorateMask);
    float3 sourceHSV = OSCO_LCR_RGBtoHSV(sourceColor);
    float3 tonedHSV = OSCO_LCR_RGBtoHSV(toned);
    float sourceChroma = OSCO_LCR_Chroma(sourceColor);
    float mutedMask = 1.0 - tonedHSV.y;
    float vibranceMask = 1.0 - saturate(tonedHSV.y * rcp(max(tonedHSV.z, 0.000001)));
    float neutralSurface = (1.0 - saturate(sourceChroma * rcp(0.12))) * smoothstep(0.28, 0.92, sourceHSV.z);
    float neutralGuard = saturate(neutralSurface * (0.55 + protection * 0.45));
    float harmonySupport = saturate(sourceHarmonySupport) *
        (1.0 - neutralGuard);
    float harmonyGuidance = saturate(OSCO_LCR_SchemePull);
    float guidedPromotion = lerp(
        1.0,
        lerp(0.55, 1.25, harmonySupport),
        harmonyGuidance);
    float harmonyBoost =
        max(OSCO_LCR_LiveSchemeBoost, 0.0) *
        harmonySupport *
        safeInvigorate;
    float sameHueSatGain =
        safeInvigorate *
        (0.06 + max(OSCO_LCR_ColorStrength, 0.0) * 0.12 + max(OSCO_LCR_MutedColorLift, 0.0) * 0.16) *
        (0.25 + mutedMask * 0.75) *
        (0.55 + vibranceMask * 0.45) *
        (1.0 + harmonyBoost * 0.18) *
        guidedPromotion *
        lerp(1.0, 0.06, neutralGuard);

    float sameHueValueGain =
        safeInvigorate *
        (0.01 +
         max(OSCO_LCR_MutedColorLift, 0.0) * 0.02 +
         harmonyBoost * 0.012) *
        (0.30 + mutedMask * 0.70) *
        guidedPromotion *
        lerp(1.0, 0.45, neutralGuard);

    float3 revivedHSV = tonedHSV;
    revivedHSV.x = recoveryHue;
    float recoveredSaturation = saturate(
        tonedHSV.y + sameHueSatGain);
    float dominantEvidence = max(
        OSCO_LCR_HueEvidence(sourceColor),
        saturate(sourceHarmonySupport));
    float vibrantTarget = saturate(max(
        recoveredSaturation,
        0.46 +
        dominantEvidence * 0.34 +
        harmonySupport * 0.12));
    revivedHSV.y = lerp(
        recoveredSaturation,
        vibrantTarget,
        saturate(sourceVibrancyDrive) * (1.0 - neutralGuard));
    revivedHSV.z = saturate(tonedHSV.z * (1.0 + sameHueValueGain));

    float3 vividRGB = OSCO_LCR_HSVtoRGB(revivedHSV);
    float tonedLuma = OSCO_LCR_Luma(toned);
    float vividLuma = OSCO_LCR_Luma(vividRGB);
    float3 lumaRestored = max(
        vividRGB + (tonedLuma - vividLuma).xxx,
        0.0.xxx);
    float3 revived = OSCO_LCR_PeakLimit(
        lerp(vividRGB, lumaRestored, 0.75),
        0.82,
        1.18);
    revived = lerp(revived, OSCO_LCR_WarmCool(revived), safeInvigorate);
    float3 neutralBase = lerp(toned, sourceColor, 0.70);
    revived = lerp(revived, neutralBase, neutralGuard * 0.88);
    return lerp(sourceColor, revived, saturate(protection * safeInvigorate));
}

float3 OSCO_LCR_DegradeColor(
    float3 sourceColor,
    float harmonySupport,
    float vibrancyDrive,
    float admissionMask,
    float protection)
{
    float sourceLuma = OSCO_LCR_Luma(sourceColor);
    float admittedEvidence = saturate(max(
        max(harmonySupport, vibrancyDrive),
        admissionMask));
    float highlightAuthority = lerp(0.55, 1.0, saturate(protection));
    float degradation = saturate(
        (0.58 + admittedEvidence * 0.34) *
        highlightAuthority);
    return saturate(lerp(sourceColor, sourceLuma.xxx, degradation));
}

float4 OSCO_LCR_PS(float4 pos : SV_Position, float2 uv : TEXCOORD) : SV_Target
{
    float2 uvSafe = OSCO_LCR_ClampUV(uv);
    float2 pixelSize = OSCO_LCR_PixelSize();
    float3 sourceColor = OSCO_LCR_LoadColor(uvSafe).rgb;

    if (OSCO_LCR_Enable == 0)
    {
        return float4(sourceColor, 1.0);
    }

    float luma = OSCO_LCR_Luma(sourceColor);
    float chroma = OSCO_LCR_Chroma(sourceColor);
    float localContrast = 0.0;
    float3 localPalette = sourceColor;
    float paletteStrength = 0.0;
    OSCO_LCR_LocalContext(
        uvSafe,
        pixelSize,
        sourceColor,
        localContrast,
        localPalette,
        paletteStrength);
    float protection = OSCO_LCR_HighlightProtection(luma);
    float midMask = OSCO_LCR_BellMask(luma, OSCO_LCR_MudMidpoint, OSCO_LCR_MudMidWidth);

    float muddySaturation = 1.0 - saturate(chroma * rcp(max(OSCO_LCR_MudSaturationCeiling, 0.0001)));
    float muddyFlatness = 1.0 - saturate(localContrast * rcp(max(OSCO_LCR_MudContrastCeiling, 0.0001)));
    float mudMask = saturate(muddySaturation * muddyFlatness * midMask * protection);

    float lowSatRecovery = 1.0 - saturate(chroma * rcp(max(OSCO_LCR_MudSaturationCeiling * 1.35, 0.0001)));
    float existingColor = OSCO_LCR_ChromaKeep(chroma, 0.015);
    float popContrast = saturate(localContrast * rcp(max(OSCO_LCR_MudContrastCeiling * 1.45, 0.0001)));
    float invigorateMask = saturate(max(existingColor * 0.35, lowSatRecovery) * (0.65 + midMask * 0.45) * (0.85 + popContrast * 0.40) * protection);
    float localColorAuthority = saturate(max(
        existingColor,
        OSCO_LCR_HueEvidence(localPalette) *
        paletteStrength));
    float mudHoldStrength = lerp(
        0.92,
        0.30,
        saturate(localColorAuthority * 1.50));
    float mudColorHold = saturate(mudMask * mudHoldStrength);
    float reviveMask = saturate(invigorateMask * (1.0 - mudColorHold));

    float harmonySupport = OSCO_LCR_ColorTheorySupport(
        sourceColor,
        localPalette,
        paletteStrength);
    float hueMigration = OSCO_LCR_HueMigrationAmount(
        sourceColor,
        localPalette,
        paletteStrength);
    float3 sourceHSV = OSCO_LCR_RGBtoHSV(sourceColor);
    float3 paletteHSV = OSCO_LCR_RGBtoHSV(localPalette);
    float recoveryHue = OSCO_LCR_HueLerp(
        sourceHSV.x,
        paletteHSV.x,
        hueMigration);
    float vibrancyDrive = OSCO_LCR_VibrancyDrive(
        sourceColor,
        localPalette,
        paletteStrength,
        harmonySupport);

    float3 revived = sourceColor;
    float3 colorResult = sourceColor;
    float3 splitColor = sourceColor;
    if (OSCO_LCR_InvertColorRecovery != 0)
    {
        colorResult = OSCO_LCR_DegradeColor(
            sourceColor,
            harmonySupport,
            vibrancyDrive,
            reviveMask,
            protection);
    }
    else
    {
        revived = OSCO_LCR_Revive(
            sourceColor,
            recoveryHue,
            harmonySupport,
            vibrancyDrive,
            reviveMask,
            protection);

        float2 splitDir = uvSafe - float2(0.5, 0.5);
        float splitLen = max(length(splitDir), 0.0001);
        splitDir *= rcp(splitLen);
        float2 splitOffset = splitDir * pixelSize * max(OSCO_LCR_ChromaticSplitPixels, 0.0) * mudMask;

        float3 splitSource = float3(
            OSCO_LCR_LoadColor(uvSafe + splitOffset).r,
            OSCO_LCR_LoadColor(uvSafe).g,
            OSCO_LCR_LoadColor(uvSafe - splitOffset).b);
        float3 splitRevived = OSCO_LCR_Revive(
            splitSource,
            recoveryHue,
            harmonySupport,
            vibrancyDrive * 0.35,
            reviveMask,
            protection);
        splitColor = lerp(splitRevived, splitSource, mudColorHold);

        float splitBlend = saturate(mudMask * OSCO_LCR_ChromaticSplitBlend * protection);
        colorResult = OSCO_LCR_PeakLimit(lerp(revived, splitColor, splitBlend), 0.84, 1.10);
    }
    float3 finalColor = colorResult;

    if (OSCO_LCR_View == 0)
    {
        return float4(finalColor, 1.0);
    }

    float3 debugColor = (OSCO_LCR_InvertColorRecovery != 0) ? colorResult : revived;
    if (OSCO_LCR_View == 2) debugColor = mudMask.xxx;
    if (OSCO_LCR_View == 3) debugColor = invigorateMask.xxx;
    if (OSCO_LCR_View == 4) debugColor = localContrast.xxx;
    if (OSCO_LCR_View == 5) debugColor = saturate(abs(splitColor - revived) * 6.0);
    if (OSCO_LCR_View == 6) debugColor = localPalette;
    if (OSCO_LCR_View == 7) debugColor = harmonySupport.xxx;
    if (OSCO_LCR_View == 8) debugColor = vibrancyDrive.xxx;
    if (OSCO_LCR_View == 9) debugColor = hueMigration.xxx;

    debugColor = OSCO_LCR_DebugVisibilityPost(
        debugColor,
        OSCO_LCR_DebugPostMode,
        OSCO_LCR_DebugExposure,
        OSCO_LCR_DebugBias,
        OSCO_LCR_DebugContrast,
        OSCO_LCR_DebugGamma,
        OSCO_LCR_DebugFloor,
        OSCO_LCR_DebugThreshold);

    return float4(debugColor, 1.0);
}

technique OSCO_LazaraColorRevival
< ui_label = "Camera Obscura Lazara Color Revival"; ui_tooltip = "Dominance-aware vibrant color recovery with an explicit inverted degradation mode. Recovery promotes only observed source or local hue evidence; degradation disables correction and removes chroma while preserving source luma."; >
{
    pass
    {
        VertexShader = PostProcessVS;
        PixelShader = OSCO_LCR_PS;
    }
}
