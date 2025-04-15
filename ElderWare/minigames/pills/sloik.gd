extends Node2D

var attached:bool = false
var clicked_position: Vector2
@onready var joint: PinJoint2D = $MousePosition/PinJoint2D
@onready var mouse_position = $MousePosition
@onready var sloik_body = $SloikBody
signal pill_exited

func _process(delta):
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		joint.node_a = ""

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		joint.node_a = NodePath(sloik_body.get_path())
		joint.node_b = NodePath(mouse_position.get_path())

		pass


func _on_area_2d_body_exited(body: PhysicsBody2D) -> void:
	body.input_pickable = true
	pass # Replace with function body.
