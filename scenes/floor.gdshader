shader_type canvas_item;

uniform float total_speed = 1.0;
uniform vec4 new_color : source_color = vec4(1.0);
uniform vec4 replace_color : source_color = vec4(1.0);
uniform sampler2D bottom_texture: hint_default_black, repeat_enable;
uniform vec2 velocity_bottom = vec2(0.1, 0.1);
uniform sampler2D middle_texture: hint_default_black, repeat_enable;
uniform vec2 velocity_middle = vec2(0.1, 0.1);
uniform sampler2D top_texture: hint_default_black, repeat_enable;
uniform vec2 velocity_top = vec2(0.1, 0.1);

void fragment() {
	//if (replace_color == COLOR){
		vec2 uv1 = vec2(SCREEN_UV.x + TIME * velocity_bottom.x * total_speed, SCREEN_UV.y + TIME * velocity_bottom.y * total_speed);
		vec4 bottom = texture(bottom_texture, uv1);
		vec2 uv2 = vec2(SCREEN_UV.x + TIME * velocity_middle.x * total_speed, SCREEN_UV.y + TIME * velocity_middle.y * total_speed);
		vec4 middle = texture(middle_texture, uv2);
		vec2 uv3 = vec2(SCREEN_UV.x + TIME * velocity_top.x * total_speed, SCREEN_UV.y + TIME * velocity_top.y * total_speed);
		vec4 top = texture(top_texture, uv3);

		COLOR += bottom;
		COLOR += middle;
		COLOR += top;
		COLOR.rgb *= new_color.rgb;
	}
//}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
