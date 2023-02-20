#ifndef _NBL_GLSL_SKINNING_RENDER_DESCRIPTOR_SET_GLSL_INCLUDED_
#define _NBL_GLSL_SKINNING_RENDER_DESCRIPTOR_SET_GLSL_INCLUDED_


#ifndef NBL_GLSL_TRANSFORM_TREE_POOL_NODE_NORMAL_MATRIX_DESCRIPTOR_BINDING
#define NBL_GLSL_TRANSFORM_TREE_POOL_NODE_NORMAL_MATRIX_DESCRIPTOR_BINDING 2
#endif
#include <3rdparty/glsl/transform_tree/render_descriptor_set.glsl>

#define NBL_GLSL_SKINNING_CACHE_JOINT_NODE_DESCRIPTOR_DECLARED
#define NBL_GLSL_SKINNING_CACHE_SKINNING_TRANSFORM_DESCRIPTOR_QUALIFIERS readonly restrict
#define NBL_GLSL_SKINNING_CACHE_SKINNING_RECOMPUTED_TIMESTAMP_DESCRIPTOR_DECLARED
#define NBL_GLSL_SKINNING_CACHE_INVERSE_BIND_POSE_OFFSET_DESCRIPTOR_DECLARED
#define NBL_GLSL_SKINNING_CACHE_INVERSE_BIND_POSE_DESCRIPTOR_DECLARED
#include <3rdparty/glsl/skinning/cache_descriptor_set.glsl>


#endif