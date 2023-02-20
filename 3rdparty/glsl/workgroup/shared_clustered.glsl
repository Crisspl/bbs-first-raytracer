#ifndef _NBL_BUILTIN_GLSL_WORKGROUP_SHARED_CLUSTERED_INCLUDED_
#define _NBL_BUILTIN_GLSL_WORKGROUP_SHARED_CLUSTERED_INCLUDED_



#include <3rdparty/glsl/workgroup/shared_ballot.glsl>



#if NBL_GLSL_WORKGROUP_REDUCTION_SCRATCH_BOUND(_NBL_GLSL_WORKGROUP_SIZE_-1)>_NBL_GLSL_WORKGROUP_BALLOT_SHARED_SIZE_NEEDED_
	#define _NBL_GLSL_WORKGROUP_CLUSTERED_SHARED_SIZE_NEEDED_  NBL_GLSL_WORKGROUP_REDUCTION_SCRATCH_BOUND(_NBL_GLSL_WORKGROUP_SIZE_-1)
#else
	#define _NBL_GLSL_WORKGROUP_CLUSTERED_SHARED_SIZE_NEEDED_  _NBL_GLSL_WORKGROUP_BALLOT_SHARED_SIZE_NEEDED_
#endif



#endif
