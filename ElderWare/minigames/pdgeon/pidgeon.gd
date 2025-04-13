extends Minigame

@onready var bent_over_pigon =  preload("res://assets/pigon_bent_over.png")
@onready var standing_pigon =  preload("res://assets/pigon_standing_proud.png")

var pidgeon_tummy = 0

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			feed()
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			$GPUParticles2D.emitting = false
			$PigonStandingProud.texture = standing_pigon
			# code
func feed():
	pidgeon_tummy += 1
	if pidgeon_tummy % 5 == 0:
		$PigonStandingProud.scale = Vector2( $PigonStandingProud.scale.x * 1.1, $PigonStandingProud.scale.x * 1.0001)
		pass
	if pidgeon_tummy == 35:
		minigame_complete.emit()
	$GPUParticles2D.emitting = true
	$PigonStandingProud.texture = bent_over_pigon
	pass
