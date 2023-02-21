#include <iostream>
#include <vector>
#include <memory>
#include <omp.h>

#define STB_IMAGE_IMPLEMENTATION
#include <3rdparty/stb_image.h>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <3rdparty/stb_image_write.h>


//#define GLM_FORCE_SSE42 //if your processor supports it
//#define GLM_FORCE_SSE2 //if your processor supports it
#define GLM_FORCE_ALIGNED
#define GLM_FORCE_AVX2

#include "glsl_integration_typedefs.h"

#include "rt_math.h"
#include <ray.h>
#include <geometry.h>
#include <Camera.h>
#include <Material.h>


using std::shared_ptr;
using std::make_shared;
using namespace geometry;

int const RECURSION_DEPTH = 8;
int const NUM_SAMPLES = 256;
int const w = 512, h = 256;

vec3 color(Ray const& r, Hitable& world, int recursion_num)
{
	HitRecord rec;
	bool intersection = world.Intersect(r, vec2(0.001, FLT_MAX), rec);
	//FIXME (OS): Magic number
	if (intersection)
	{
		vec3 u = random_variable<vec3>();

		Ray scattered(vec3(0), vec3(0));
		vec3 quotient; // eval/pdf * NdotL
		bool does_scatter = rec.mat->Scatter(r, rec, u, quotient, scattered);
		if (does_scatter && (recursion_num < RECURSION_DEPTH))
		{
			return quotient * color(scattered, world, recursion_num + 1);
		}
		else
		{
			return vec3(0);
		}
	}

	// sky shading
	vec3 dir = r.direction;

	dir /= sqrt(dot(r.direction, r.direction));
	float t = 0.5 * (dir.y + 1.0);
	vec3 sky = r.direction * vec3(.5f) + vec3(.5f);
	//vec3 sky = lerp(vec3(1, 1, 1), vec3(.5, .7, 1), t);
	return sky;
}


vec3 sample(Hitable& world, Camera const& camera, ivec2 const& pos, int const num_samples, Randomization const randomization)
{
	const float num_rcp = 1.0f / static_cast<float>(num_samples);

	vec3 accum;
	for (int i = 0; i < num_samples; ++i)
	{
		Ray r = camera.make_ray(pos, randomization);
		accum += color(r, world, 0) * num_rcp;
	}
	return accum;
}

int trace(Hitable& world, int w, int h, unsigned char * img)
{
	vec3 pos = vec3(8.5, 1.8, -2.4f);
	Camera camera(58.f, pos, vec3(0., 1., 0.), vec3(0., 0., 0), length(pos - vec3(4,1,0)), .075);
	camera.set_image_size(ivec2(w, h));
	#pragma omp parallel for
	for (int j = 0; j < h; ++j)
	{
		#pragma omp parallel for
		for (int i = 0; i < w; ++i)
		{
			vec3 c = sample(world, camera, ivec2(i, j), NUM_SAMPLES, Randomization::MonteCarlo);
			c = sqrt(c);
			//magic number for float truncation
			img[(j*w + i) * 3 + 0] = int(c.r * 255.99);
			img[(j*w + i) * 3 + 1] = int(c.g * 255.99);
			img[(j*w + i) * 3 + 2] = int(c.b * 255.99);
		}
	}
	return 0;
}

#define ENABLE_DIELECTRIC 1

int main()
{
	const mat2x3 ior_Au = mat2x3(
		vec3(0.21415f, 0.52329f, 1.3319f),
		vec3(3.2508f, 2.2714f, 1.8693f)
	);

	unsigned char *img = new unsigned char[w * h * 3];

	HitableList world;

	int n = 4;
	
	//hacky floor in the form of a sphere
	auto floor = make_shared<Sphere>(vec3(0, -1000, 0), 1000);
	floor->material = make_shared<Lambertian>(vec3(0.2f, 0.2, 0.7), 1.f);
	world.Add(floor);

	for (int a = -n; a < n; ++a)
	{
		for (int b = -n; b < n; ++b)
		{
			float choose_mat = linearRand(0.f, 1.f);
			vec3 center(a + 0.9* linearRand(0.f, 1.f), 0.2, b + 0.9 * linearRand(0.f, 1.f));
			if (length(center - vec3(4.0, 0.2, 0)) > .9)
			{
				auto sphere = make_shared<Sphere>(center, 0.2f);
				world.Add(sphere);
				if (choose_mat < 0.4)
				{
					vec3 c = linearRand(vec3(0.f), vec3(1.f));
					c = c*c;
					float a = linearRand(0.f, 1.f);
					sphere->material = make_shared<Lambertian>(c, a);
				}
				else if (choose_mat < 0.7) // ENABLE_DIELECTRIC
				{
					sphere->material = make_shared<Metal>(ior_Au, linearRand(0.1f, 0.8f));
				}
#if ENABLE_DIELECTRIC
				else
				{
					sphere->material = make_shared<Dielectric>(linearRand(1.33f, 1.76f), linearRand(0.001f, 0.2f));
				}
#endif
			}
		}
	}

	//Hero spheres
#if ENABLE_DIELECTRIC
	auto crazy = make_shared<Sphere>(vec3(0, 1, 0), 1.0);
	crazy->material = make_shared<Dielectric>(1.1f, 0.05f);
#endif
	auto sexy = make_shared<Sphere>(vec3(-4, 1, 0), 0.6f);
	sexy->material = make_shared<Lambertian>(vec3(0.5, 0.2, 0.5), 0.4f);
	auto cool = make_shared<Sphere>(vec3(4, 1, 0), 1.0);
	cool->material = make_shared<Metal>(ior_Au, 0.2f);
#if ENABLE_DIELECTRIC
	world.Add(crazy);
#endif
	world.Add(sexy);
	world.Add(cool);

	BVHNode bvh(world);
	
	int result;
	result = trace(bvh, w, h, img);

	stbi_write_png("image.png", w, h, 3, img, w*3);

	delete[] img;
	return 0;
}