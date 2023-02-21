#pragma once

#include <3rdparty\glm\glm.hpp>
#include <cmath>

#define NBL_GLSL_API inline

#define in
#define out

using glm::min;
using glm::max;
using glm::clamp;

using glm::normalize;
using glm::dot;
using glm::mix;

using glm::fract;
using glm::sign;
using glm::inversesqrt;
using glm::floatBitsToUint;
using glm::floatBitsToInt;
using glm::intBitsToFloat;
using glm::uintBitsToFloat;

using glm::findMSB;
using glm::bitfieldExtract;
using glm::bitfieldInsert;

using glm::mat2;
using glm::mat3x2;
using glm::mat4x2;

using glm::mat2x3;
using glm::mat3;
using glm::mat4x3;

using glm::mat2x4;
using glm::mat3x4;
using glm::mat4;

using glm::vec2;
using glm::vec3;
using glm::vec4;
using glm::uint;
using glm::uvec2;
using glm::uvec3;
using glm::uvec4;
using glm::ivec2;
using glm::ivec3;
using glm::ivec4;

template <typename V>
inline vec2 xy(const V& v)
{
	return vec2(v);
}

template <typename V>
inline vec3 xyz(const V& v)
{
	return vec3(v);
}

template <typename V>
inline vec2 yx(const V& v)
{
	return vec2(v.y, v.x);
}

template <typename V>
inline vec2 yy(const V& v)
{
	return vec2(v.y, v.y);
}

template <typename V>
inline vec2 xx(const V& v)
{
	return vec2(v.x, v.x);
}

template <typename V>
inline vec3 xxx(const V& v)
{
	return vec3(v.x,v.x,v.x);
}

template <typename V>
inline vec3 yyy(const V& v)
{
	return vec3(v.y, v.y, v.y);
}

template <typename V>
inline vec3 zzz(const V& v)
{
	return vec3(v.z, v.z, v.z);
}

template <typename V>
inline vec3 zyx(const V& v)
{
	return vec3(v.z, v.y, v.x);
}

template <typename V>
inline vec3 xxy(const V& v)
{
	return vec3(v.x, v.x, v.y);
}

template <typename V>
inline vec3 xxz(const V& v)
{
	return vec3(v.x, v.x, v.z);
}

template <typename V>
inline vec3 xyx(const V& v)
{
	return vec3(v.x, v.y, v.x);
}

template <typename V>
inline vec3 xyy(const V& v)
{
	return vec3(v.x, v.y, v.y);
}

template <typename V>
inline vec3 xzx(const V& v)
{
	return vec3(v.x, v.z, v.x);
}

template <typename V>
inline vec3 xzy(const V& v)
{
	return vec3(v.x, v.z, v.y);
}

template <typename V>
inline vec3 xzz(const V& v)
{
	return vec3(v.x, v.z, v.z);
}
