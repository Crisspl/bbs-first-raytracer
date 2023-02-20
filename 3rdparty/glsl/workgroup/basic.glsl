#ifndef _NBL_BUILTIN_GLSL_WORKGROUP_BASIC_INCLUDED_
#define _NBL_BUILTIN_GLSL_WORKGROUP_BASIC_INCLUDED_


#include <3rdparty/glsl/math/typeless_arithmetic.glsl>
#include <3rdparty/glsl/subgroup/basic_portability.glsl>	


//! all functions must be called in uniform control flow (all workgroup invocations active)
bool nbl_glsl_workgroupElect()
{
	return gl_LocalInvocationIndex==0u;
}


#endif
