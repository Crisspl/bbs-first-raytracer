#ifndef _NBL_BUILTIN_GLSL_IEE754_H_INCLUDED_
#define _NBL_BUILTIN_GLSL_IEE754_H_INCLUDED_

NBL_GLSL_API uint nbl_glsl_ieee754_exponent_bias(in uint exponentBits)
{
	return (0x1u << (exponentBits - 1)) - 1;
}
NBL_GLSL_API uint nbl_glsl_ieee754_extract_biased_exponent(float x)
{
	return bitfieldExtract(floatBitsToUint(x), 23, 8);
}
NBL_GLSL_API int nbl_glsl_ieee754_extract_exponent(float x)
{
	return int(nbl_glsl_ieee754_extract_biased_exponent(x) - nbl_glsl_ieee754_exponent_bias(8));
}
NBL_GLSL_API uint nbl_glsl_ieee754_compute_exponent_mask(in uint exponentBits, in uint mantissaBits)
{
	return ((1 << exponentBits) - 1) << mantissaBits;
}
NBL_GLSL_API float nbl_glsl_ieee754_replace_biased_exponent(float x, uint exp_plus_bias)
{
	return uintBitsToFloat(bitfieldInsert(floatBitsToUint(x), exp_plus_bias, 23, 8));
}
// performs no overflow tests, returns x*exp2(n)
NBL_GLSL_API float nbl_glsl_ieee754_fast_mul_exp2(float x, int n)
{
	return nbl_glsl_ieee754_replace_biased_exponent(x, nbl_glsl_ieee754_extract_biased_exponent(x) + uint(n));
}
NBL_GLSL_API uint nbl_glsl_ieee754_compute_mantissa_mask(in uint mantissaBits)
{
	return (0x1u << mantissaBits) - 1;
}
NBL_GLSL_API uint nbl_glsl_ieee754_extract_mantissa(in float x)
{
	return (floatBitsToUint(x) & 0x7fffffu);
}
NBL_GLSL_API float nbl_glsl_ieee754_true_min(in uint exponentBits, in uint mantissaBits)
{
	return exp2(1 - int(nbl_glsl_ieee754_exponent_bias(exponentBits)) - mantissaBits);
}
NBL_GLSL_API float nbl_glsl_ieee754_min(in uint exponentBits, in uint mantissaBits)
{
	const float e = exp2(1 - int(nbl_glsl_ieee754_exponent_bias(exponentBits)));
	const uint m = 0x1u << (23 - mantissaBits);
	return uintBitsToFloat(floatBitsToUint(e) | m);
}
NBL_GLSL_API float nbl_glsl_ieee754_max(in uint exponentBits, in uint mantissaBits)
{
	const uint biasedMaxExp = (((1 << exponentBits) - 1) - 1); // `(1 << exponentBits) - 1` is reserved for Inf/NaN.
	const float e = exp2(biasedMaxExp - int(nbl_glsl_ieee754_exponent_bias(exponentBits)));
	const uint m = 0x7fFFffu & (0x7fFFffu << (23 - mantissaBits));
	return uintBitsToFloat(floatBitsToUint(e) | m);
}
NBL_GLSL_API uint nbl_glsl_ieee754_encode_ufloat_impl(in int exponent, in uint exponentBits, in uint mantissa, in uint mantissaBits)
{
	const uint expBias = nbl_glsl_ieee754_exponent_bias(exponentBits);
	const uint e = uint(exponent + expBias);
	const uint m = mantissa >> (23 - mantissaBits);
	const uint encodedValue = (e << mantissaBits) | m;
	return encodedValue;
}


NBL_GLSL_API float nbl_glsl_numeric_limits_float_epsilon(float n);
NBL_GLSL_API float nbl_glsl_numeric_limits_float_epsilon(int n);
NBL_GLSL_API float nbl_glsl_numeric_limits_float_epsilon();

NBL_GLSL_API float nbl_glsl_ieee754_gamma(float n)
{
	const float a = nbl_glsl_numeric_limits_float_epsilon(n);
	return a / (1.f - a);
}
NBL_GLSL_API float nbl_glsl_ieee754_rcpgamma(float n)
{
	const float a = nbl_glsl_numeric_limits_float_epsilon(n);
	return 1.f / a - 1.f;
}

NBL_GLSL_API float nbl_glsl_ieee754_gamma(uint n)
{
	return nbl_glsl_ieee754_gamma(float(n));
}
NBL_GLSL_API float nbl_glsl_ieee754_rcpgamma(uint n)
{
	return nbl_glsl_ieee754_rcpgamma(float(n));
}

NBL_GLSL_API vec3 nbl_glsl_ieee754_add_with_bounds_wo_gamma(out vec3 error, in vec3 a, in vec3 a_error, in vec3 b, in vec3 b_error)
{
	error = (a_error + b_error) / nbl_glsl_numeric_limits_float_epsilon(1);
	vec3 sum = a + b;
	error += abs(sum);
	return sum;
}
NBL_GLSL_API vec3 nbl_glsl_ieee754_sub_with_bounds_wo_gamma(out vec3 error, in vec3 a, in vec3 a_error, in vec3 b, in vec3 b_error)
{
	error = (a_error + b_error) / nbl_glsl_numeric_limits_float_epsilon(1);
	vec3 sum = a - b;
	error += abs(sum);
	return sum;
}
NBL_GLSL_API vec3 nbl_glsl_ieee754_mul_with_bounds_wo_gamma(out vec3 error, in vec3 a, in vec3 a_error, in float b, in float b_error)
{
	vec3 crossCorrelationA = abs(a) * b_error;
	vec3 crossCorrelationB = a_error * abs(b);
	error = (crossCorrelationB + crossCorrelationA + crossCorrelationB * crossCorrelationA) / nbl_glsl_numeric_limits_float_epsilon(1);
	vec3 product = a * b;
	error += abs(product);
	return product;
}

#endif