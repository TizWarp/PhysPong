shader_type canvas_item;

void fragment() {
  // Animate Sprite moving in big circle around its location
  COLOR = vec4(TIME*20.0);
}
