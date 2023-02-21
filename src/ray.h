#pragma once
#include <iostream>
#include <memory>

#include "glsl_integration_typedefs.h"
#include <3rdparty/glsl/bxdf/common.glsl>

class Material;

class Ray
{
public:
	Ray(vec3 const& origin, vec3 const& direction) : origin(origin), direction(direction) {}
	
	vec3 At(float t) const { return origin + t * direction; }

	vec3 origin, direction;

};

struct HitRecord
{
	float t;
	vec3 point;
	vec3 normal;
	std::shared_ptr<Material> mat;

	nbl_glsl_AnisotropicViewSurfaceInteraction interaction;

	void setInteraction(const Ray* r, vec3 n)
	{
		nbl_glsl_IsotropicViewSurfaceInteraction ii;
		ii = nbl_glsl_calcSurfaceInteractionFromViewVector(-(r->direction), n);

		// tangent frame computed with frisvad
		interaction = nbl_glsl_calcAnisotropicInteraction(ii);
	}
};