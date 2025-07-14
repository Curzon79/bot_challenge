shader_type canvas_item;

uniform float radius = 0.2;

void fragment() {
	float x = UV.x;
	float y = UV.y;
	if (x > 0.5) x = 1.0 - x;
	if (y > 0.5) y = 1.0 - y;
	
	if (x < radius && y < radius &&
	   (pow(x - radius, 2) + pow(y - radius, 2) > pow(radius, 2))){
		COLOR.a = 0.0;
		
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
