#ifndef _NBL_GLSL_SCENE_ANIMATION_INCLUDED_
#define _NBL_GLSL_SCENE_ANIMATION_INCLUDED_


#include <3rdparty/glsl/math/keyframe.glsl>


NBL_GLSL_API struct nbl_glsl_scene_Animation_t
{
	uint keyframeOffset; // same offset for timestamps and keyframes
	uint keyframesCount_interpolationMode; // 2 bits for interpolation mode
};

// TODO: Design for this
NBL_GLSL_API struct nbl_glsl_scene_AnimationBlend_t
{
	uint nodeTargetID;
	uint desiredTimestamp;
	float weight;
	uint animationID; // or do we stick whole animation inside?
};

#endif