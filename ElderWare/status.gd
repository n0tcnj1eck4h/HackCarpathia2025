extends Label

# Shake configuration
var shake_enabled := true
var shake_intensity := 5.0
var shake_speed := 50.0
var vertical_shake := false

# Rainbow configuration
var rainbow_enabled := true
var color_change_speed := 1.0
var saturation := 0.8
var value := 1.0

var original_position: Vector2
var hue: float = 0.0
var time: float = 0.0

func _ready():
	original_position = self.position
	start_effects()

func _process(delta):
	time += delta
	
	if rainbow_enabled:
		hue = fmod(hue + color_change_speed * delta, 1.0)
		modulate = Color.from_hsv(hue, saturation, value)
	
	if shake_enabled:
		var x_shake = sin(time * shake_speed) * shake_intensity
		var y_shake = randf_range(-shake_intensity, shake_intensity)
		self.position = original_position + Vector2(x_shake, y_shake)

func start_effects():
	set_process(true)

func stop_effects():
	set_process(false)
	reset_appearance()

func reset_appearance():
	self.position = original_position
	modulate = Color.WHITE

func set_shake_intensity(new_intensity: float):
	shake_intensity = new_intensity

func set_color_speed(new_speed: float):
	color_change_speed = new_speed
