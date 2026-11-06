// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

#ifndef CAMERA_OBSCURA_API_TRANSMIGRATION_FXH
#define CAMERA_OBSCURA_API_TRANSMIGRATION_FXH

#include "CAMERA_OBSCURA_API_Common.fxh"

#define CAMERA_OBSCURA_API_MINE_STATE_RAW 0
#define CAMERA_OBSCURA_API_MINE_STATE_MAPPED 1
#define CAMERA_OBSCURA_API_MINE_STATE_PROVEN 2
#define CAMERA_OBSCURA_API_MINE_STATE_ADMITTED 3

struct CAMERA_OBSCURA_API_MinedShape
{
    float state;
    float shape_gate;
    float proof_gate;
    float admission_gate;
    float rollback_gate;
};

CAMERA_OBSCURA_API_MinedShape CAMERA_OBSCURA_API_DefaultMinedShape()
{
    CAMERA_OBSCURA_API_MinedShape shape;
    shape.state = CAMERA_OBSCURA_API_MINE_STATE_RAW;
    shape.shape_gate = 0.0;
    shape.proof_gate = 0.0;
    shape.admission_gate = 0.0;
    shape.rollback_gate = 0.0;
    return shape;
}

float CAMERA_OBSCURA_API_MinedShapeReady(CAMERA_OBSCURA_API_MinedShape shape)
{
    return step(
        0.5,
        min(
            min(shape.shape_gate, shape.proof_gate),
            min(shape.admission_gate, shape.rollback_gate)));
}

#endif // CAMERA_OBSCURA_API_TRANSMIGRATION_FXH
