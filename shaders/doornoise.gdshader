shader_type spatial;
uniform sampler2D noise;
render_mode unshaded;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = texture(noise, UV + (TIME*5.)).rgb;
	ALPHA = texture(noise, UV + (TIME*7.)).r;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
