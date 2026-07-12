shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0);
uniform bool fill = true;
uniform float size = 40;

void fragment() {
	float x = abs(fract(FRAGCOORD.x/size) -0.5);
	float y = abs(fract(FRAGCOORD.y/size) -0.5);
	if (x+y + UV.y> progress*2.0){
		if (fill){
			discard;
		}
	}
	else if (!fill){
		discard;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
