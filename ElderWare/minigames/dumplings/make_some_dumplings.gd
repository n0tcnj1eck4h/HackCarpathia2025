extends Node2D





const unmade_dumpling_scene = preload(
	"res://minigames/dumplings/unmade_dumpling.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 5:
		spawn_dumpling()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func gen_random_pos() -> Vector2:
	var spawnArea = $DumplingSpawner/CollisionShape2D.shape.extents
	var origin = $DumplingSpawner/CollisionShape2D.global_position - spawnArea
	var x = randf_range(origin.x, spawnArea.x)
	var y = randf_range(origin.y, spawnArea.y)
	
	return Vector2(x, y)
	

func spawn_dumpling() -> void:
	var unmade_dumpling = unmade_dumpling_scene.instantiate()
	unmade_dumpling.position = gen_random_pos()
	
	add_child(unmade_dumpling)
