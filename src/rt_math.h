#pragma once
#include "3rdparty\glm\glm.hpp"
#include "3rdparty\glm\gtc\random.hpp"

using glm::vec3;
using glm::vec2;

float sum_parts(vec3 const& v)
{
	return v.x + v.y + v.z;
}

vec3 reflect(vec3 inp, vec3 normal)
{
	return inp - 2.f * dot(inp, normal) * normal;
}

bool refract(vec3 inp, vec3 normal, float ni_over_no, vec3& refracted)
{
	float h = dot(normalize(inp), normal);
	float discriminant = 1 - ni_over_no * ni_over_no * (1 - h * h);
	if (discriminant > 0)
	{
		refracted = ni_over_no * (inp - normal * h) - normal * sqrt(discriminant);
		return true;
	}
	else
	{
		return false;
	}
}

float schlick(float costheta, float index)
{
	float r0 = (1 - index) / (1 + index);
	r0 *= r0;
	float z = (1 - costheta);
	z = z * z * z * z * z;
	return r0 + (1 - r0) * z;
}


template <typename T>
T random_variable()
{
	return glm::linearRand(T(0.f), T(1.f));
}

vec3 sample_in_sphere(vec3 center, vec3 radius)
{
	vec3 outp;
	do 
	{ 
		outp = linearRand(vec3(-1), vec3(1)); 
	} while (dot(outp, outp) >= 1);
	return outp * radius + center;
}

vec2 sample_in_disk(vec2 center, vec2 radius)
{
	vec2 outp;
	do
	{
		outp = linearRand(vec2(-1.f), vec2(1.f));
	} while (dot(outp, outp) >= 1);
	return outp * radius + center;
}


inline vec3 lerp(vec3 const v1, vec3 const v2, float t)
{
	return v1 * (1 - t) + v2 * t;
}

