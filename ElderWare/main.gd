extends Node2D

@onready var porażka_dot_wav: AudioStreamPlayer = $porażkaDotWav
@onready var wygrana_dot_wav: AudioStreamPlayer = $wygranaDotWav


var score = 0
const MINIGAMES = [
	{"scene":preload("res://minigames/test/test.tscn"), "message":"test"},
	{"scene":preload("res://minigames/pills/getyourmeds.tscn"),"message":"Get your meds!"},
	{"scene":preload("res://minigames/police/police.tscn"),"message":"Call the police!"},
	{"scene":preload("res://minigames/stroke_that_cat/stroke_that_cat.tscn"),"message":"Stroke that cat!"},
	{"scene":preload("res://minigames/dumplings/make_some_dumplings.tscn","message":"Make dumplings!")}
]

var clock
var cameraposin
var minigame_dict

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Status.visible = false
	clock = $GrandfatherClock.get_child(1)
	clock.time_ended.connect(self._on_minigame_failed)
	cameraposin = $Camera.zoom
	minigame_dict = MINIGAMES.pick_random()
	self._next_minigame()

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
	minigame_dict = MINIGAMES.pick_random()
	self.zoom_out()
	self._clear_minigame()
	score -= 1
	$Status.text = "Porażka"
	$Status.visible = true
	$Status.text = minigame_dict.message
	clock.kill_babushka()
	await get_tree().create_timer(2.0).timeout
	self.zoom_in()
	$Status.visible = false
	self._next_minigame()

func _on_minigame_complete():
	minigame_dict = MINIGAMES.pick_random()
	self.zoom_out()
	self._clear_minigame()
	wygrana_dot_wav.play()
	score += 1
	$Status.text = minigame_dict.message
	$Status.visible = true
	$Score.text = "Score: %s" % score
	clock.yipie()
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
	
	

	
