shader_type canvas_item;

uniform vec4 color_from_1 : source_color = vec4(1.0);
uniform vec4 color_from_2 : source_color = vec4(1.0);

uniform vec4 color_to_1 : source_color = vec4(1.0);
uniform vec4 color_to_2 : source_color = vec4(1.0);

uniform float tolerance = 0.01;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    if (distance(tex_color, color_from_1) < tolerance) {
        COLOR = vec4(color_to_1.rgb, tex_color.a);
    }
    else if (distance(tex_color, color_from_2) < tolerance) {
        COLOR = vec4(color_to_2.rgb, tex_color.a);
    }
    else {
        COLOR = tex_color;
    }
}
