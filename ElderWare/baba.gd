extends Node2D

var cycle = 0.0
var end_pos = 175.0
var start_pos = 1000.0
var y_pos = 550.0
var time = 10.0
var speed = (start_pos - end_pos) / time 
var dead = false

signal time_ended

func _ready() -> void:
	self.reset()

func _physics_process(delta: float) -> void:
	if not self.dead:
		cycle -= delta  * 2 * PI
		$Babalimbs.position = Vector2(20, 0).rotated(cycle)
		self.position.x -= speed * delta
		if self.position.x <= end_pos:
			time_ended.emit()
			self.kill_babushka()


func reset():
	self.position.x = start_pos
	self.position.y = y_pos
	self.dead = false
	self.rotation = 0.0
	
func kill_babushka():
	self.rotate(PI / 2)
	self.dead = true
	
