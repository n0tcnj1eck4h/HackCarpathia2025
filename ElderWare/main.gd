extends Node2D

var score = 0
const MINIGAMES = [
	preload("res://minigames/test/test.tscn"),
	preload("res://minigames/pills/getyourmeds.tscn"),
	preload("res://minigames/police/police.tscn"),
]

var clock
var cameraposin

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Status.visible = false
	clock = $GrandfatherClock.get_child(1)
	clock.time_ended.connect(self._on_minigame_failed)
	cameraposin = $Camera.zoom
	self._next_minigame()

func _clear_minigame():
	%"Łapa".gigapaluch(false)
	for child in $MinigameContainer.get_children():
		child.queue_free()

func _next_minigame():
	var minigame = MINIGAMES.pick_random().instantiate()
	minigame.mingame_failed.connect(self._on_minigame_failed)
	minigame.minigame_complete.connect(self._on_minigame_complete)
	self._clear_minigame()
	$MinigameContainer.add_child(minigame) 
	clock.reset()

func _on_minigame_failed():
	self.zoom_out()
	self._clear_minigame()
	score -= 1
	$Status.text = "Porażka"
	$Status.visible = true
	$Score.text = "Score: %s" % score
	clock.kill_babushka()
	await get_tree().create_timer(2.0).timeout
	self.zoom_in()
	$Status.visible = false
	self._next_minigame()

func _on_minigame_complete():
	self.zoom_out()
	self._clear_minigame()
	score += 1
	$Status.text = "Tak trzymaj!"
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
	
	

	
