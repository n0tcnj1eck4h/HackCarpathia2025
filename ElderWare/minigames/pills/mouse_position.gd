extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	velocity = (get_global_mouse_position() - global_position) * 100
	move_and_slide()
