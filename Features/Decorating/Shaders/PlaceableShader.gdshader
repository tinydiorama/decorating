shader_type canvas_item;

uniform bool PREVIEW = false;
uniform bool PLACEABLE = true;

void fragment() {
	vec4 previousColor = texture(TEXTURE, UV);
	vec4 whiteColor = vec4(1.0, 1.0, 1.0, previousColor.a);
	vec4 newColor = previousColor;
	
	if ( PREVIEW == true ) {
		
		// shade
		if ( PLACEABLE == false ) {
			newColor.r = 0.9;
			newColor.g = newColor.g / 2.0;
			newColor.b = newColor.b / 2.0;
		} else {
			newColor = texture(TEXTURE, UV);
		}
		
		// opacity
		if ( newColor.a == 1.0 ) {
			newColor.a = 0.75;
		}
	} else {
		newColor = texture(TEXTURE, UV);
	}
	
	COLOR = newColor;
}