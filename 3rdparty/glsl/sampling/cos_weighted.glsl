// Copyright (C) 2018-2020 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BUILTIN_GLSL_SAMPLING_COS_WEIGHTED_INCLUDED_
#define _NBL_BUILTIN_GLSL_SAMPLING_COS_WEIGHTED_INCLUDED_

#include <3rdparty/glsl/sampling/concentric_mapping.glsl>

NBL_GLSL_API vec3 nbl_glsl_projected_hemisphere_generate(in vec2 _sample)
{
    vec2 p = nbl_glsl_concentricMapping(_sample*0.99999f+0.000005f);
    
    float z = sqrt(max(0.0f, 1.0f - p.x*p.x - p.y*p.y));
    
    return vec3(p.x,p.y,z);
}

NBL_GLSL_API float nbl_glsl_projected_hemisphere_pdf(in float L_z)
{
    return L_z * nbl_glsl_RECIPROCAL_PI;
}

NBL_GLSL_API float nbl_glsl_projected_hemisphere_remainder_and_pdf(out float& pdf, in float L_z)
{
	pdf = nbl_glsl_projected_hemisphere_pdf(L_z);
	return 1.0f;
}
NBL_GLSL_API float nbl_glsl_projected_hemisphere_remainder_and_pdf(out float& pdf, in vec3 L)
{
	return nbl_glsl_projected_hemisphere_remainder_and_pdf(pdf,L.z);
}

NBL_GLSL_API vec3 nbl_glsl_projected_sphere_generate(vec3& _sample)
{
    vec3 retval = nbl_glsl_projected_hemisphere_generate(vec2(_sample));
    const bool chooseLower = _sample.z>0.5f;
    retval.z = chooseLower ? (-retval.z):retval.z;
    if (chooseLower)
        _sample.z -= 0.5f;
    _sample.z *= 2.f;
    return retval;
}

NBL_GLSL_API float nbl_glsl_projected_sphere_remainder_and_pdf(out float& pdf, in float L_z)
{
    float retval = nbl_glsl_projected_hemisphere_remainder_and_pdf(pdf,L_z);
    pdf *= 0.5f;
	return retval;
}
NBL_GLSL_API float nbl_glsl_projected_sphere_remainder_and_pdf(out float& pdf, in vec3 L)
{
    return nbl_glsl_projected_sphere_remainder_and_pdf(pdf,L.z);
}

NBL_GLSL_API float nbl_glsl_projected_sphere_pdf(in float L_z)
{
    return 0.5f*nbl_glsl_projected_hemisphere_pdf(L_z);
}

#endif
