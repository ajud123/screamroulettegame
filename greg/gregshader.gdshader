shader_type spatial;
render_mode unshaded;

uniform sampler2D layerOne;
uniform sampler2D layerTwo;
uniform sampler2D layerClosed;
uniform vec2 offset;
uniform bool eyeClosed = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(eyeClosed){
		ALBEDO.rgb = texture(layerClosed, UV).rgb;
		ALPHA = texture(layerClosed, UV).a;
	}
	else {
		vec4 col1 = texture(layerOne, UV);
		vec4 col2 = texture(layerTwo, UV + offset);
		ALBEDO.rgb = (col1.rgb * (col1.a - col2.a)) + (col2.rgb * col2.a);
		ALPHA = col1.a;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
