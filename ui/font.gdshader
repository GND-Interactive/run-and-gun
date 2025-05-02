shader_type canvas_item;

uniform vec4 top_color : source_color;
uniform vec4 bottom_color : source_color;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	COLOR = mix(top_color, bottom_color, UV.y);
	COLOR.a = tex.a;
}
