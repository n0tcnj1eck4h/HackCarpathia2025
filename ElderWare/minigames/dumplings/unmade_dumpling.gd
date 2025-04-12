extends Area2D

const dumpling = preload("res://minigames/dumplings/dumpling.tscn")

func _on_area_entered(area: Area2D):
	if area.is_in_group("filling"):
		var spawn_pos = self.global_position
		queue_free()
		area.queue_free()

		if dumpling:
			var new_instance = dumpling.instantiate()
			get_tree().current_scene.add_child(new_instance)
			new_instance.global_position = spawn_pos
