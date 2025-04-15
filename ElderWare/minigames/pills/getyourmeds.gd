extends Minigame


func _on_good_pill_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		minigame_complete.emit()
	pass # Replace with function body.
