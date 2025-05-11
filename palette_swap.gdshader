shader_type canvas_item;

uniform int mode = 0; // 0: arriba rojo, 1: arriba azul, 2: izquierda rojo, 3: izquierda azul

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Colores
    vec4 red = vec4(1.0, 0.0, 0.0, 0.2);
    vec4 blue = vec4(0.0, 0.0, 1.0, 0.2); // azul claro y semitransparente

    vec4 color;

    if (mode == 0) {
        // Arriba rojo, abajo azul
        color = (UV.y < 0.5) ? mix(tex_color, red, 0.5) : mix(tex_color, blue, 0.5);
    } else if (mode == 1) {
        // Arriba azul, abajo rojo
        color = (UV.y < 0.5) ? mix(tex_color, blue, 0.5) : mix(tex_color, red, 0.5);
    } else if (mode == 2) {
        // Izquierda rojo, derecha azul
        color = (UV.x < 0.5) ? mix(tex_color, red, 0.5) : mix(tex_color, blue, 0.5);
    } else if (mode == 3) {
        // Izquierda azul, derecha rojo
        color = (UV.x < 0.5) ? mix(tex_color, blue, 0.5) : mix(tex_color, red, 0.5);
    }

    COLOR = color;
}