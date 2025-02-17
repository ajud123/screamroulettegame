//yoinked from acerola
shader_type canvas_item;

uniform float _RedColorCount;
uniform float _GreenColorCount;
uniform float _BlueColorCount;
uniform float u_dither_size;
uniform float _Spread;

const int bayer2[4] = { //2x2
    0, 2,
    3, 1
};

const int bayer4[16] = { //4x4
    0, 8, 2, 10,
    12, 4, 14, 6,
    3, 11, 1, 9,
    15, 7, 13, 5
};

const int bayer8[64] = { //8x8
    0, 32, 8, 40, 2, 34, 10, 42,
    48, 16, 56, 24, 50, 18, 58, 26,
    12, 44,  4, 36, 14, 46,  6, 38,
    60, 28, 52, 20, 62, 30, 54, 22,
    3, 35, 11, 43,  1, 33,  9, 41,
    51, 19, 59, 27, 49, 17, 57, 25,
    15, 47,  7, 39, 13, 45,  5, 37,
    63, 31, 55, 23, 61, 29, 53, 21
};

float GetBayer2(int x, int y) {
    return float(bayer2[(x % 2) + (y % 2) * 2]) * (1.0f / 4.0f) - 0.5f;
}

float GetBayer4(int x, int y) {
    return float(bayer4[(x % 4) + (y % 4) * 4]) * (1.0f / 16.0f) - 0.5f;
}

float GetBayer8(int x, int y) {
    return float(bayer8[(x % 8) + (y % 8) * 8]) * (1.0f / 64.0f) - 0.5f;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 screen_size = vec2(textureSize(TEXTURE, 0)) / float(u_dither_size);
	vec2 screen_size_pure = vec2(textureSize(TEXTURE, 0));
	vec2 screen_sample_uv = floor(UV * screen_size) / screen_size;
	vec3 screen_col = texture(TEXTURE, screen_sample_uv).rgb;

	float bayer = GetBayer8(int(UV.x * screen_size.x), int(UV.y * screen_size.y));
	vec3 output = screen_col + _Spread * bayer;
	output.r = floor((_RedColorCount - 1.0f) * output.r + 0.5) / (_RedColorCount - 1.0f);
	output.g = floor((_GreenColorCount - 1.0f) * output.g + 0.5) / (_GreenColorCount - 1.0f);
	output.b = floor((_BlueColorCount - 1.0f) * output.b + 0.5) / (_BlueColorCount - 1.0f);
	COLOR.rgb = output;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
