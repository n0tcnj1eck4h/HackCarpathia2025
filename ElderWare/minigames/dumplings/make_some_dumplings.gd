extends Minigame

const dumpling_scene = preload("res://minigames/dumplings/dumpling.tscn")
signal make_dumpling(position: Vector2)

func _on_lose():
	self.mingame_failed.emit()

func _on_win():
	self.minigame_complete.emit()
	

func _spawn_dumpling(position: Vector2):
	var new_dumpling = dumpling_scene.instantiate()
	add_child(new_dumpling)
	new_dumpling.global_position = position
	
func _ready():
	for child in $"Unmade dumplings".get_children():
		child.connect("make_dumpling", Callable(self, "_spawn_dumpling"))

func _process(delta):
	if($"Unmade dumplings".get_child_count() == 0):
		_on_win()
