#pragma once
#include <3rdparty/glm/glm.hpp>
#include <3rdparty/glm/gtc/random.hpp>
#include "ray.h"
#include "rt_math.h"

#include "glsl_integration_typedefs.h"
#include <3rdparty/glsl/bxdf/brdf/specular/beckmann.glsl>
#include <3rdparty/glsl/bxdf/bsdf/specular/beckmann.glsl>
#include <3rdparty/glsl/bxdf/brdf/diffuse/oren_nayar.glsl>

using namespace glm;

class Material
{
public:
	virtual bool Scatter(Ray const& ray_in, HitRecord const& rec, vec3 const& u, vec3& quotient, Ray& ray_scattered) const = 0;
};


class Lambertian : public Material
{
	float a2() const { return a * a; }

public:
	explicit Lambertian(vec3 Albedo, float a) : Albedo(Albedo), a(a) {}
	bool Scatter(Ray const& ray_in, HitRecord const& rec, vec3 const& u, vec3& quotient, Ray& ray_scattered) const override
	{
		nbl_glsl_LightSample s = nbl_glsl_oren_nayar_cos_generate(rec.interaction, xy(u), a2());

		ray_scattered = Ray(rec.point, s.L);

		float pdf = 0.f;
		quotient = Albedo * nbl_glsl_oren_nayar_cos_remainder_and_pdf(pdf, s, rec.interaction.isotropic, a2());

		return true;
	}
	
	float a;
	vec3 Albedo;
};

class Metal : public Material
{
	float a2() const { return Roughness*Roughness; }

public:
	explicit Metal(mat2x3 ior, float Roughness=0.01f) : ior(ior), Roughness(Roughness) {}
	
	bool Scatter(Ray const& ray_in, HitRecord const& rec, vec3 const& u, vec3& quotient, Ray& ray_scattered) const override
	{
		if (Roughness > 0)
		{
			nbl_glsl_AnisotropicMicrofacetCache mf;
			nbl_glsl_LightSample s = nbl_glsl_beckmann_cos_generate(rec.interaction, xy(u), Roughness, Roughness, mf);

			ray_scattered = Ray(rec.point, s.L);

			float pdf = 0.f;
			quotient = nbl_glsl_beckmann_cos_remainder_and_pdf(pdf, s, rec.interaction.isotropic, mf.isotropic, ior, a2());

			return true;
		}

		//roughness==0
		//delta distribution
		vec3 reflected = reflect(ray_in.direction, rec.normal);
		ray_scattered = Ray(rec.point, reflected);
		assert(0); //nothing written to quotient

		return true;
	}
	
	mat2x3 ior;
	float Roughness;
};

class Dielectric : public Material
{
	float a2() const { return a * a; }

public:
	explicit Dielectric(float Index, float a):Eta(Index), a(a) {}

	bool Scatter(Ray const& ray_in, HitRecord const& rec, vec3 const& u, vec3& quotient, Ray& ray_scattered) const override
	{
		vec3 u_ = u;
		nbl_glsl_AnisotropicMicrofacetCache mf;
		nbl_glsl_LightSample s = nbl_glsl_beckmann_dielectric_cos_generate(rec.interaction, u_, a, a, Eta, mf);

		ray_scattered = Ray(rec.point, s.L);

		float pdf = 0.f;
		quotient = vec3(1.f) * nbl_glsl_beckmann_dielectric_cos_remainder_and_pdf(pdf, s, rec.interaction.isotropic, mf.isotropic, Eta, a2());

		return true;
	}

	float Eta;
	float a;
};