// Copyright (C) 2018-2020 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BUILTIN_GLSL_BXDF_COMMON_SAMPLES_INCLUDED_
#define _NBL_BUILTIN_GLSL_BXDF_COMMON_SAMPLES_INCLUDED_

#include <3rdparty/glsl/math/functions.glsl>
#include <3rdparty/glsl/bxdf/common.glsl>

NBL_GLSL_API nbl_glsl_LightSample nbl_glsl_transmission_cos_generate(in nbl_glsl_AnisotropicViewSurfaceInteraction interaction)
{
    return nbl_glsl_createLightSample(-interaction.isotropic.V.dir,-1.0,interaction.T,interaction.B,interaction.isotropic.N);
}

/** Why don't we check that the incoming and outgoing directions equal each other (or similar for other delta distributions such as reflect, or smooth [thin] dielectrics:
- The `remainder_and_pdf` functions are meant to be used with MIS
- Our own generator can never pick an improbable path, so no checking necessary
- For other generators the estimator will be `f_BSDF*f_Light*f_Visibility*clampedCos(theta)/(1+(p_BSDF^alpha+p_otherNonChosenGenerator^alpha+...)/p_ChosenGenerator^alpha)`
	when `p_BSDF` equals `nbl_glsl_FLT_INF` it will drive the overall MIS estimator for the other generators to 0 so no checking necessary
**/
NBL_GLSL_API float nbl_glsl_transmission_cos_remainder_and_pdf(out float& pdf)
{
	pdf = nbl_glsl_FLT_INF;
	return 1.0;
}

NBL_GLSL_API nbl_glsl_LightSample nbl_glsl_reflection_cos_generate(in nbl_glsl_AnisotropicViewSurfaceInteraction interaction)
{
    const vec3 L = nbl_glsl_reflect(interaction.isotropic.V.dir,interaction.isotropic.N,interaction.isotropic.NdotV);
    return nbl_glsl_createLightSample(L,interaction);
}

// for information why we don't check the relation between `V` and `L` or `N` and `H`, see comments for `nbl_glsl_transmission_cos_remainder_and_pdf`
NBL_GLSL_API float nbl_glsl_reflection_cos_remainder_and_pdf(out float& pdf)
{
	pdf = nbl_glsl_FLT_INF;
	return 1.0;
}

#endif
