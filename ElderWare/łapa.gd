extends Node2D

const grab = preload("res://assets/lapa_squeez.png")
const ungrab = preload("res://assets/lapa_relaxed.png")
const paluch = preload("res://assets/paluch.png")

var ispaluch = false
var off

func _ready() -> void:
	off = $Sprite2D.position

func gigapaluch(p: bool):
	if p:
		$Sprite2D.texture = paluch
	ispaluch = p

func _process(delta: float) -> void:
	self.position = get_global_mouse_position()
	if not self.ispaluch:
		if Input.is_mouse_button_pressed(1):
			$Sprite2D.texture = grab
		else:
			$Sprite2D.texture = ungrab
	else: 		
		if Input.is_mouse_button_pressed(1):
			$Sprite2D.position = off + Vector2(-10, -10)
		else:
			$Sprite2D.position = off
		
		
