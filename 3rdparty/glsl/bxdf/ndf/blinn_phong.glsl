// Copyright (C) 2018-2020 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BXDF_NDF_BLINN_PHONG_INCLUDED_
#define _NBL_BXDF_NDF_BLINN_PHONG_INCLUDED_

#include <3rdparty/glsl/math/constants.glsl>
#include <3rdparty/glsl/bxdf/ndf/common.glsl>

NBL_GLSL_API float nbl_glsl_blinn_phong(in float NdotH, in float n)
{
    return isinf(n) ? nbl_glsl_FLT_INF : nbl_glsl_RECIPROCAL_PI*0.5*(n+2.0) * pow(NdotH,n);
}
//ashikhmin-shirley ndf
NBL_GLSL_API float nbl_glsl_blinn_phong(in float NdotH, in float one_minus_NdotH2_rcp, in float TdotH2, in float BdotH2, in float nx, in float ny)
{
    float n = (TdotH2*ny + BdotH2*nx) * one_minus_NdotH2_rcp;

    return (isinf(nx)||isinf(ny)) ?  nbl_glsl_FLT_INF : sqrt((nx + 2.0)*(ny + 2.0))*nbl_glsl_RECIPROCAL_PI*0.5 * pow(NdotH,n);
}

#endif