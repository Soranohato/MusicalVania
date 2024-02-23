shader_type canvas_item;

/* This shader changes the hue of a single CanvasItem that it's attached to.*/

// Target hue color will be in the center of our acceptable window
uniform vec3 target_hue_color : source_color = vec3(1.0, 0.0, 0.0); // Default is red

// Tolerance for acceptable hues is how big the acceptable window is
uniform float hue_tolerance : hint_range(0.0, 1.0) = 0.1; // My favorite tolerance is around 0.1

// These are for a later calculation and represent the possible range of all hues
uniform float range_max = 360;
uniform float range_min = 0;

// Algorithm found from https://github.com/godotengine/godot-proposals/issues/8635
vec3 rgb2hsv(vec3 rgb) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(rgb.bg, K.wz), vec4(rgb.gb, K.xy), step(rgb.b, rgb.g));
	vec4 q = mix(vec4(p.xyw, rgb.r), vec4(rgb.r, p.yzx), step(p.x, rgb.r));
	
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Algorithm found from https://github.com/godotengine/godot-proposals/issues/8635
vec3 hsv2rgb(vec3 hsv) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(hsv.xxx + K.xyz) * 6.0 - K.www);
	return hsv.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), hsv.y);
}

// Expression found from stack overflow somewhere
float map_to_range(float value, float target_min, float target_max) {
    return ((value - range_min) / (range_max - range_min)) * (target_max - target_min) + target_min;
}

float calculate_hue_mapping(float original_hue, float target_hue, float tolerance) {
	// Steps:
	// Imagine the range of all possible hues shifted so that target_hue is at 0.
	// With target hue at 0, our tolerable hues window will be between +/-tolerance.
	// Map our original_hue into this window. Somehow
	// Add the value of target_hue to our interpolated value in order to shift it back to that original spot.
	// Only keep the fractional component of the hue so it wraps around properly.
	// Return the value hopefully successfully
	
    float target_max = 360.0 * tolerance;
    float target_min = 360.0 * (-1.0 * tolerance);

    // map the hue into the tolerable window
    float mapped_raw = map_to_range(original_hue, target_max, target_min);
    // adjust the new mapping to be in the range of the target hue
    float mapped_adjusted = mapped_raw + target_hue;

    // check if we wrapped around
    if (mapped_adjusted > 360.0) {
      mapped_adjusted = mapped_adjusted - 360.0;
    }
    if (mapped_adjusted < 0.0) {
      mapped_adjusted = mapped_adjusted + 360.0;
    }

    return mapped_adjusted;
}

void vertex() {
    // Transformations can go here if needed
}

void fragment() {
    // Input color from the texture
    vec4 color = texture(TEXTURE, UV);

    // Convert RGB to HSV
    vec3 hsv = rgb2hsv(color.rgb);
	vec3 target_hsv = rgb2hsv(target_hue_color);

    // Calculate hue mapping
    float hue_mapping = calculate_hue_mapping(hsv.x, target_hsv.x, hue_tolerance);

    // Set the hue based on mapping
    hsv.x = hue_mapping;

    // Convert HSV back to RGB
    vec3 rgb = hsv2rgb(hsv);

    // Output the adjusted color
    COLOR = vec4(rgb, color.a);
}
