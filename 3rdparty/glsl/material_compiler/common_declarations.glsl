// Copyright (C) 2018-2021 - DevSH Graphics Programming Sp. z O.O.
// This file is part of the "Nabla Engine".
// For conditions of distribution and use, see copyright notice in nabla.h

#ifndef _NBL_BUILTIN_GLSL_MATERIAL_COMPILER_COMMON_DECLARATIONS_INCLUDED_
#define _NBL_BUILTIN_GLSL_MATERIAL_COMPILER_COMMON_DECLARATIONS_INCLUDED_

#include <3rdparty/glsl/virtual_texturing/extensions.glsl>
#include <3rdparty/glsl/material_compiler/common_invariant_declarations.glsl>

NBL_GLSL_API struct nbl_glsl_MC_bsdf_data_t
{
	uvec4 data[sizeof_bsdf_data];
};

#endif