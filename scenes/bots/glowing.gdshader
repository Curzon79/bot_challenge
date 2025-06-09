shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);

void fragment() {
	COLOR.rgb = color.rgb;
	COLOR.rgb += vec3(1.0);
	COLOR.rgb -= vec3(distance(UV, vec2(0.5,0.5))* 3.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
