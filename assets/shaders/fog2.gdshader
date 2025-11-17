shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable, filter_nearest;
uniform float density: hint_range(0.0, 1.0) = 1;
uniform vec2 speed = vec2(0.03, 0.002);

void fragment() {
	//move
	vec2 uv = UV + speed * TIME;
	// Sample the noise texture
	float noise = texture(noise_texture, uv).r;
	//convert values
	float fog = clamp(noise * 2.0 - 1.0, 0.0, 1.0);
	//Apply the fog effect
	COLOR.a *= fog * density;
}
