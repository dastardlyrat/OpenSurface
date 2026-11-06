// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_FACADE_LIFECYCLE_FXH
#define CAMERA_OBSCURA_API_FACADE_LIFECYCLE_FXH

// CO-MIG-018 / source task CO-31.
// Cold evidence only. This surface records replacement and retirement state.
// It does not expose historical lens names, dependencies, taps, offsets, loops,
// texture reads, sampling behavior, traversal authority, or runtime dispatch.

#define CAMERA_OBSCURA_API_FACADE_STATE_CURRENT_ACTIVE 0
#define CAMERA_OBSCURA_API_FACADE_STATE_HOLD_REPLACEMENT 1
#define CAMERA_OBSCURA_API_FACADE_STATE_REMOVAL_ALLOWED 2
#define CAMERA_OBSCURA_API_FACADE_STATE_HOLD_ROLLBACK 3
#define CAMERA_OBSCURA_API_FACADE_STATE_LEGACY_BLOCKED 4

struct CAMERA_OBSCURA_API_FacadeLifecycleDecision
{
    float facade_active;
    float current_selected;
    float removal_allowed;
    float legacy_blocked;
    float state;
};

float CAMERA_OBSCURA_API_FacadeFlag(float value)
{
    return step(0.5, value);
}

CAMERA_OBSCURA_API_FacadeLifecycleDecision CAMERA_OBSCURA_API_EvaluateFacadeLifecycle(
    float publicSurfacePresent,
    float currentReplacementReady,
    float replacementProven,
    float legacyDependencyPresent,
    float rollbackReady,
    float removalRequested)
{
    CAMERA_OBSCURA_API_FacadeLifecycleDecision decision;

    float surfacePresent = CAMERA_OBSCURA_API_FacadeFlag(publicSurfacePresent);
    float currentReady = CAMERA_OBSCURA_API_FacadeFlag(currentReplacementReady);
    float proofReady = CAMERA_OBSCURA_API_FacadeFlag(replacementProven);
    float legacyPresent = CAMERA_OBSCURA_API_FacadeFlag(legacyDependencyPresent);
    float rollbackAvailable = CAMERA_OBSCURA_API_FacadeFlag(rollbackReady);
    float removalWanted = CAMERA_OBSCURA_API_FacadeFlag(removalRequested);
    float currentUsable = surfacePresent * currentReady * proofReady;

    decision.facade_active = surfacePresent;
    decision.current_selected = currentUsable;
    decision.removal_allowed = 0.0;
    decision.legacy_blocked = legacyPresent;
    decision.state = CAMERA_OBSCURA_API_FACADE_STATE_HOLD_REPLACEMENT;

    if (legacyPresent > 0.5)
    {
        decision.state = CAMERA_OBSCURA_API_FACADE_STATE_LEGACY_BLOCKED;
    }
    else if (currentUsable < 0.5)
    {
        decision.state = CAMERA_OBSCURA_API_FACADE_STATE_HOLD_REPLACEMENT;
    }
    else if (removalWanted > 0.5 && rollbackAvailable < 0.5)
    {
        decision.state = CAMERA_OBSCURA_API_FACADE_STATE_HOLD_ROLLBACK;
    }
    else if (removalWanted > 0.5 && rollbackAvailable > 0.5)
    {
        decision.facade_active = 0.0;
        decision.removal_allowed = 1.0;
        decision.state = CAMERA_OBSCURA_API_FACADE_STATE_REMOVAL_ALLOWED;
    }
    else
    {
        decision.state = CAMERA_OBSCURA_API_FACADE_STATE_CURRENT_ACTIVE;
    }

    return decision;
}

float CAMERA_OBSCURA_API_FacadeLifecycleColdReady(
    CAMERA_OBSCURA_API_FacadeLifecycleDecision decision)
{
    float noLegacy = 1.0 - CAMERA_OBSCURA_API_FacadeFlag(decision.legacy_blocked);
    float selectedOrRetired = saturate(
        CAMERA_OBSCURA_API_FacadeFlag(decision.current_selected) +
        CAMERA_OBSCURA_API_FacadeFlag(decision.removal_allowed));
    return noLegacy * selectedOrRetired;
}

#endif // CAMERA_OBSCURA_API_FACADE_LIFECYCLE_FXH
