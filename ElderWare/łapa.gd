extends Node2D

const grab = preload("res://assets/lapa_squeez.png")
const ungrab = preload("res://assets/lapa_relaxed.png")

func _process(delta: float) -> void:
	self.position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(1):
		$Sprite2D.texture = grab
	else:
		$Sprite2D.texture = ungrab
		
