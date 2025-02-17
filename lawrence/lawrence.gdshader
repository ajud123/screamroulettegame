shader_type spatial;
render_mode unshaded;

uniform sampler2D noise;
uniform float limit;
uniform float div;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//todo: finish lawrence
	float a = texture(noise, UV).r;
	
	ALPHA = a > limit ? a/div : 0.;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
