// Copyright (C) 2018-2020 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BXDF_BSDF_DIFFUSE_LAMBERT_INCLUDED_
#define _NBL_BXDF_BSDF_DIFFUSE_LAMBERT_INCLUDED_

#include <3rdparty/glsl/bxdf/common.glsl>
#include <3rdparty/glsl/sampling/cos_weighted.glsl>

NBL_GLSL_API float nbl_glsl_lambertian_transmitter()
{
    return nbl_glsl_RECIPROCAL_PI*0.5;
}

NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_eval_rec_2pi_factored_out_wo_clamps(in float absNdotL)
{
   return absNdotL;
}
NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_eval_rec_2pi_factored_out(in float NdotL)
{
   return nbl_glsl_lambertian_transmitter_cos_eval_rec_2pi_factored_out_wo_clamps(abs(NdotL));
}

NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_eval_wo_clamps(in float absNdotL)
{
   return nbl_glsl_lambertian_transmitter_cos_eval_rec_2pi_factored_out_wo_clamps(absNdotL)*nbl_glsl_lambertian_transmitter();
}
NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_eval(in nbl_glsl_LightSample _sample)
{
   return nbl_glsl_lambertian_transmitter_cos_eval_rec_2pi_factored_out(_sample.NdotL)*nbl_glsl_lambertian_transmitter();
}

NBL_GLSL_API nbl_glsl_LightSample nbl_glsl_lambertian_transmitter_cos_generate_wo_clamps(in vec3 tangentSpaceV, in mat3 m, inout vec3& u)
{
    vec3 L = nbl_glsl_projected_sphere_generate(u);
    
    return nbl_glsl_createLightSampleTangentSpace(tangentSpaceV,L,m);
}
NBL_GLSL_API nbl_glsl_LightSample nbl_glsl_lambertian_transmitter_cos_generate(in nbl_glsl_AnisotropicViewSurfaceInteraction interaction, inout vec3& u)
{
    return nbl_glsl_lambertian_transmitter_cos_generate_wo_clamps(nbl_glsl_getTangentSpaceV(interaction),nbl_glsl_getTangentFrame(interaction),u);
}


NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_remainder_and_pdf_wo_clamps(out float& pdf, in float absNdotL)
{
    return nbl_glsl_projected_sphere_remainder_and_pdf(pdf,absNdotL);
}
NBL_GLSL_API float nbl_glsl_lambertian_transmitter_cos_remainder_and_pdf(out float& pdf, in nbl_glsl_LightSample s)
{
    return nbl_glsl_lambertian_transmitter_cos_remainder_and_pdf_wo_clamps(pdf,abs(s.NdotL));
}

NBL_GLSL_API float nbl_glsl_lambertian_transmitter_pdf_wo_clamps(in float absNdotL)
{
    return nbl_glsl_projected_sphere_pdf(absNdotL);
}

#endif
