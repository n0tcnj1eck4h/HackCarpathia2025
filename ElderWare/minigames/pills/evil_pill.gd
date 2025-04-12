extends Node2D

var rpm = 1.0
var velocity = Vector2(200, 50)
var size := Vector2(32, 32)

signal evil_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Area2D".input_event.connect(_on_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var r = rpm * PI * 2 * delta
	self.rotate(r)
	self.position += velocity * delta
	var viewport_rect := get_viewport_rect()


	if position.x + size.x/2 > viewport_rect.size.x:
		position.x = viewport_rect.size.x - size.x/2
		velocity.x = -velocity.x

	# Left edge
	elif position.x - size.x/2 < 0:
		position.x = size.x/2
		velocity.x = -velocity.x

	# Bottom edge
	if position.y + size.y/2 > viewport_rect.size.y:
		position.y = viewport_rect.size.y - size.y/2
		velocity.y = -velocity.y

	# Top edge
	elif position.y - size.y/2 < 0:
		position.y = size.y/2
		velocity.y = -velocity.y
	pass
	
func _on_input_event(viewport: Viewport, event: InputEvent, idx: int) -> void:
	if event is InputEventMouse:
		if event.is_pressed() and self.get_viewport_rect().has_point(event.position):
			self.queue_free()
