// Copyright (C) 2018-2020 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BUILTIN_GLSL_UTILS_COMMON_INCLUDED_
#define _NBL_BUILTIN_GLSL_UTILS_COMMON_INCLUDED_

#include "nbl/builtin/glsl/math/functions.glsl"


NBL_GLSL_API struct nbl_glsl_SBasicViewParameters
{
    mat4 MVP;
    mat4x3 MV;
    mat4x3 NormalMatAndEyePos;
};

NBL_GLSL_API mat3 nbl_glsl_SBasicViewParameters_GetNormalMat(in mat4x3 _NormalMatAndEyePos)
{
    return mat3(_NormalMatAndEyePos);
}
NBL_GLSL_API vec3 nbl_glsl_SBasicViewParameters_GetEyePos(in mat4x3 _NormalMatAndEyePos)
{
    return _NormalMatAndEyePos[3];
}

#endif
