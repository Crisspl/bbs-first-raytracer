#ifndef _NBL_GLSL_SCAN_DECLARATIONS_INCLUDED_
#define _NBL_GLSL_SCAN_DECLARATIONS_INCLUDED_


#include <3rdparty/glsl/scan/parameters_struct.glsl>


#ifndef _NBL_GLSL_SCAN_GET_PARAMETERS_DECLARED_
NBL_GLSL_API nbl_glsl_scan_Parameters_t nbl_glsl_scan_getParameters();
#define _NBL_GLSL_SCAN_GET_PARAMETERS_DECLARED_
#endif


#ifndef _NBL_GLSL_SCAN_STORAGE_TYPE_
#error "_NBL_GLSL_SCAN_STORAGE_TYPE_ needs to be defined to any of uint/int/float"
#endif

#ifndef nbl_glsl_scan_Storage_t
#define nbl_glsl_scan_Storage_t _NBL_GLSL_SCAN_STORAGE_TYPE_
#endif


#ifndef _NBL_GLSL_SCAN_GET_PADDED_DATA_DECLARED_
NBL_GLSL_API void nbl_glsl_scan_getData(
	inout nbl_glsl_scan_Storage_t& data,
	in uint levelInvocationIndex,
	in uint localWorkgroupIndex,
	in uint treeLevel,
	in uint pseudoLevel
);
#define _NBL_GLSL_SCAN_GET_PADDED_DATA_DECLARED_
#endif

#ifndef _NBL_GLSL_SCAN_SET_DATA_DECLARED_
NBL_GLSL_API void nbl_glsl_scan_setData(
	in nbl_glsl_scan_Storage_t data,
	in uint levelInvocationIndex,
	in uint localWorkgroupIndex,
	in uint treeLevel,
	in uint pseudoLevel,
	in bool inRange
);
#define _NBL_GLSL_SCAN_SET_DATA_DECLARED_
#endif

#endif