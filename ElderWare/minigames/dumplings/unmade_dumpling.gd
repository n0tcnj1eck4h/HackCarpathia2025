extends Area2D

signal make_dumpling(position: Vector2)

func _on_area_entered(area: Area2D):
	if area.is_in_group("filling"):
		queue_free()
		area.queue_free()
		emit_signal("make_dumpling", self.global_position)
