extends Node2D


var is_dragging = false;
var mouse_offset = Vector2(0, 0)


func _process(delta):
	if is_dragging:
		position = get_global_mouse_position()



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position + get_global_mouse_position()
			is_dragging = true
		else:
			is_dragging = false
