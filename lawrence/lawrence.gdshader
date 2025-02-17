shader_type spatial;
render_mode unshaded;

uniform sampler2D noise;
uniform float limit;
uniform float div;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture;
uniform float distanceModifier;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec4 upos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, FRAGCOORD.z, 1.0);
	vec3 pixel_position = upos.xyz / upos.w;
	float dist = pixel_position.z + distanceModifier;
	//todo: finish lawrence
	float a = texture(noise, UV + TIME*8.).r;
	// (a > limit ? a/div : 0.) * 
	ALPHA = a * pow(1. - distance(UV, vec2(0.5, 0.5)) / 0.5, 5.) / 10. * dist;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
