shader_type canvas_item;

uniform float total_speed = 1.0;
uniform vec4 new_color : source_color = vec4(1.0);
uniform sampler2D bottom_texture: hint_default_black, repeat_enable;
uniform vec2 velocity_bottom = vec2(0.1, 0.1);
uniform sampler2D turn_part: hint_default_black;

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

void fragment() {
	float alpha = COLOR.a;
	vec2 uv1 = vec2(SCREEN_UV.x + TIME * velocity_bottom.x * total_speed, SCREEN_UV.y + TIME * velocity_bottom.y * total_speed);
	vec4 bottom = texture(bottom_texture, uv1);
	vec2 rotated_uv = rotate(UV, vec2(0.5), -TIME * total_speed);
	vec4 turn_thingy = texture(turn_part, rotated_uv);
	
	COLOR += bottom;
	COLOR += vec4(turn_thingy.a);
	COLOR += vec4(turn_thingy.a);
	COLOR *= new_color;
	COLOR.a = alpha;
}
