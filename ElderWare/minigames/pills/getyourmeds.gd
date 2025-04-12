extends Minigame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_bouncy_entities()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

const BouncyEntityScene = preload("res://minigames/pills/evil_pill.tscn")
const HealthyEntityScene = preload("res://minigames/pills/good_pill.tscn")

func spawn_bouncy_entities() -> void:
	var viewport_size := self.get_viewport_rect().size
	
	var pill = HealthyEntityScene.instantiate()
	add_child(pill)
	pill.epic_signal.connect(self.minigame_complete.emit)
	pill.position = Vector2(
		randf_range(0, viewport_size.x),
		randf_range(0, viewport_size.y)
	)

	pill.velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(10.0, 500.0)
	pill.rpm = randf_range(-4, 4)
	var pillscale = randf_range(1, 4)
	pill.apply_scale(Vector2(pillscale, pillscale))
	
	for i in range(20):
		var entity = BouncyEntityScene.instantiate()
		add_child(entity)
		entity.epic_signal.connect(self.mingame_failed.emit)
		entity.position = Vector2(
			randf_range(0, viewport_size.x),
			randf_range(0, viewport_size.y)
		)
		
		# Set random velocity (direction and speed)
		var direction := Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var speed := randf_range(10.0, 500.0)
		entity.velocity = direction * speed
		entity.rpm = randf_range(-4, 4)
		var scale = randf_range(1, 4)
		entity.apply_scale(Vector2(scale, scale))
