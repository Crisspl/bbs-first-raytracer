#ifndef _NBL_GLSL_BLIT_NORMALIZATION_SHARED_NORMALIZATION_DEFINED_
#define _NBL_GLSL_BLIT_NORMALIZATION_SHARED_NORMALIZATION_DEFINED_

#include <3rdparty/glsl/workgroup/shared_arithmetic.glsl>
#define _NBL_GLSL_BLIT_NORMALIZATION_SHARED_SIZE_NEEDED_ (_NBL_GLSL_WORKGROUP_ARITHMETIC_SHARED_SIZE_NEEDED_+1)

#ifdef _NBL_GLSL_SCRATCH_SHARED_DEFINED_
	#if NBL_GLSL_EVAL(_NBL_GLSL_SCRATCH_SHARED_SIZE_DEFINED_)<NBL_GLSL_EVAL(_NBL_GLSL_BLIT_NORMALIZATION_SHARED_SIZE_NEEDED_)
	#error "Not enough shared memory for normalization"
	#endif
#else
	shared uint nbl_glsl_blit_normalization_scratchShared[_NBL_GLSL_BLIT_NORMALIZATION_SHARED_SIZE_NEEDED_];
	#define _NBL_GLSL_SCRATCH_SHARED_DEFINED_ nbl_glsl_blit_normalization_scratchShared
	#define _NBL_GLSL_SCRATCH_SHARED_SIZE_DEFINED_ _NBL_GLSL_BLIT_NORMALIZATION_SHARED_SIZE_NEEDED_
#endif

#endif