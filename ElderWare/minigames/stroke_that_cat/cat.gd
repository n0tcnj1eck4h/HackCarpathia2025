extends Node2D

enum strokeArea{BUTT, HEAD, NONE}

var last_area_entered: strokeArea = strokeArea.NONE;
var satisfaction: int = 0;
var last_satisfaction: int = 0;
@export var satisfaction_needed_for_happy: int = 15;
@export var satisfaction_change: int = 2;
@onready var progress_bar = $ProgressBar/SatisfactionBar;
@onready var progress_bar_tip = $ProgressBar/CatProgressBarHead
@onready var progress_bar_start = $ProgressBar/BarStart
@onready var progress_bar_end = $ProgressBar/BarEnd
var head_texture =	preload("res://assets/cat_progress_bar_head.png")
var happy_head_texture = preload("res://assets/cat_progress_bar_head_happy.png")

signal cat_satisfied;

func _on_head_area_mouse_shape_entered(shape_idx: int) -> void:
	if last_area_entered != strokeArea.HEAD:
		satisfaction+= satisfaction_change
		if(satisfaction >= 100):
				cat_satisfied.emit()
		progress_bar.value = satisfaction
		progress_bar_tip.position = progress_bar_start.position.lerp(progress_bar_end.position,float(satisfaction)/100)
	pass # Replace with function body.


func _on_butt_area_mouse_shape_entered(shape_idx: int) -> void:
	if last_area_entered != strokeArea.BUTT:
		satisfaction += satisfaction_change
		if(satisfaction >= 100):
			cat_satisfied.emit()
		progress_bar.value = satisfaction
		progress_bar_tip.position = progress_bar_start.position.lerp(progress_bar_end.position,float(satisfaction)/100)
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	if( satisfaction - last_satisfaction > satisfaction_needed_for_happy):
		progress_bar_tip.texture = happy_head_texture
	else:
		progress_bar_tip.texture = head_texture
	last_satisfaction = satisfaction
	pass # Replace with function body.
