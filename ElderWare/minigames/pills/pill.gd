extends RigidBody2D

@export_enum("Red", "Green") var color: int

const TEXTURES = [
	preload("res://assets/pigulka2.png"),
	preload("res://assets/pigulki.png"),
]

func _ready() -> void:
	$Pigulka2.texture = TEXTURES[color]
