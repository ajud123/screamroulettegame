// NOTE: Shader automatically converted from Godot Engine 4.3.stable.mono's StandardMaterial3D.

shader_type spatial;
render_mode unshaded;


uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D texture_albedo2 : source_color, filter_linear_mipmap, repeat_enable;
uniform float gamma = 1.0;

void vertex() {
	 //NODE_POSITION_CLIP = (PROJECTION_MATRIX * vec4(NODE_POSITION_VIEW, 1.0));
	//UV = UV * uv1_scale.xy + uv1_offset.xy;
}

void fragment() {
	//vec2 local_uv = (SCREEN_UV * 2.0 - 1.0) * NODE_POSITION_CLIP.w - NODE_POSITION_CLIP.xy;
	//
	//// Adjust for aspect ratio and FOV
	//local_uv.x *= VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
	//local_uv *= -1.0 / PROJECTION_MATRIX[1][1];
	
	vec2 base_uv = UV;

	vec4 albedo_tex3 = texture(texture_albedo, SCREEN_UV);
	albedo_tex3.rgb = pow(albedo_tex3.rgb, vec3(1.0 / gamma));

	if(FRONT_FACING)
		ALBEDO = albedo_tex3.rgb; //vec3(SCREEN_UV.rg, 0.);
	else
		ALBEDO = albedo_tex3.rgb;
}

void light() {
	
}