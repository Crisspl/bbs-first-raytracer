#ifndef _NBL_GLSL_CULLING_LOD_SELECTION_OUTPUT_DESCRIPTOR_MODIFIERS_GLSL_INCLUDED_
#define _NBL_GLSL_CULLING_LOD_SELECTION_OUTPUT_DESCRIPTOR_MODIFIERS_GLSL_INCLUDED_


#include <3rdparty/glsl/culling_lod_selection/output_descriptor_set.glsl>

NBL_GLSL_API uint nbl_glsl_culling_lod_selection_drawCallInstanceCountIncr(in uint drawCallDWORDOffset)
{
    return atomicAdd(drawCalls.data[drawCallDWORDOffset+1u],1u);
}

NBL_GLSL_API void nbl_glsl_culling_lod_selection_drawCallSetDWORD(in uint DWORDOffset, in uint value)
{
    drawCalls.data[DWORDOffset] = value;
}
NBL_GLSL_API void nbl_glsl_culling_lod_selection_drawCallSetInstanceCount(in uint drawCallDWORDOffset, in uint instanceCount)
{
    drawCalls.data[drawCallDWORDOffset+1u] = instanceCount;
}
NBL_GLSL_API void nbl_glsl_culling_lod_selection_drawArraysSetBaseInstance(in uint drawCallDWORDOffset, in uint baseInstance)
{
    drawCalls.data[drawCallDWORDOffset+3u] = baseInstance;
}
NBL_GLSL_API void nbl_glsl_culling_lod_selection_drawElementsSetBaseInstance(in uint drawCallDWORDOffset, in uint baseInstance)
{
    drawCalls.data[drawCallDWORDOffset+4u] = baseInstance;
}


#endif