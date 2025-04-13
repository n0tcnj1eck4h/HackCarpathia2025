extends Node2D

@onready var porażka_dot_wav: AudioStreamPlayer = $porażkaDotWav
@onready var wygrana_dot_wav: AudioStreamPlayer = $wygranaDotWav


var score = 0
const MINIGAMES = [
	{"scene":preload("res://minigames/test/test.tscn"), "message":"test"},
	{"scene":preload("res://minigames/pills/getyourmeds.tscn"),"message":"Get your meds!"},
	{"scene":preload("res://minigames/police/police.tscn"),"message":"Call the police!"},
	{"scene":preload("res://minigames/stroke_that_cat/stroke_that_cat.tscn"),"message":"Stroke that cat!"},
	{"scene":preload("res://minigames/dumplings/make_some_dumplings.tscn"),"message":"Make dumplings!"}
]

var clock
var cameraposin
var minigame_dict
var hp: int = 4
@onready var hp_nodes = [$Node2D/Hp,$Node2D/Hp2,$Node2D/Hp3,$Node2D/Hp4]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Status.visible = false
	clock = $GrandfatherClock.get_child(1)
	clock.time_ended.connect(self._on_minigame_failed)
	cameraposin = $Camera.zoom
	handle_transition()

func _clear_minigame():
	%"Łapa".gigapaluch(false)
	for child in $MinigameContainer.get_children():
		child.queue_free()

func _next_minigame():
	var minigame = minigame_dict.scene.instantiate()
	minigame.mingame_failed.connect(self._on_minigame_failed)
	minigame.minigame_complete.connect(self._on_minigame_complete)

	self._clear_minigame()
	$MinigameContainer.add_child(minigame) 
	clock.reset()

func _on_minigame_failed():
	
	
	clock.kill_babushka()
	handle_transition()
	hp_nodes[hp-1].queue_free()
	hp -= 1

func _on_minigame_complete():
	wygrana_dot_wav.play()
	score += 1
	clock.yipie()
	handle_transition()

func handle_transition():
	minigame_dict = MINIGAMES.pick_random()
	self.zoom_out()
	self._clear_minigame()
	$Status.text = minigame_dict.message
	$Status.visible = true
	$Score.text = "Score: %s" % score
	await get_tree().create_timer(2.0).timeout
	self.zoom_in()
	$Status.visible = false
	self._next_minigame()

func zoom_out():
	var tween = self.create_tween()
	tween.tween_property($Camera, "zoom", cameraposin / 4, 0.3)
	await tween
	$TV.visible = true
	#$Camera.zoom = cameraposin / 4	
	
func zoom_in():
	var tween = self.create_tween()
	tween.tween_property($Camera, "zoom", cameraposin, 0.3)
	await tween.finished
	$TV.visible = false
	
