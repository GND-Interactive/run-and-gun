shader_type canvas_item;
uniform int mode = 0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Colores
    vec4 red = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 blue = vec4(0.0, 0.0, 1.0, 1.0);

    vec4 color = tex_color;

    if (tex_color.a > 0.0) {
        if (mode == 0) {
            // Dividir en 20 franjas verticales, izq rojo, der azul
            int stripe_index = int(UV.x * 20.0);
            bool is_even = (stripe_index % 2) == 0;
            vec4 overlay = is_even ? red : blue;
            color.rgb = mix(tex_color.rgb, overlay.rgb, 0.5);

        } else if (mode == 1) {
            // izq azul, der rojo
            int stripe_index = int(UV.x * 20.0);
            bool is_even = (stripe_index % 2) == 0;
            vec4 overlay = is_even ? blue : red;
            color.rgb = mix(tex_color.rgb, overlay.rgb, 0.5);

        } else if (mode == 2) {
            // arriba rojo, abajo azul
            int stripe_index = int(UV.y * 20.0);
            bool is_even = (stripe_index % 2) == 0;
            vec4 overlay = is_even ? red : blue;
            color.rgb = mix(tex_color.rgb, overlay.rgb, 0.5);

        } else if (mode == 3) {
            // arriba azul, abajo rojo
            int stripe_index = int(UV.y * 20.0);
            bool is_even = (stripe_index % 2) == 0;
            vec4 overlay = is_even ? blue : red;
            color.rgb = mix(tex_color.rgb, overlay.rgb, 0.5);
        }
    }

    COLOR = color;
}
