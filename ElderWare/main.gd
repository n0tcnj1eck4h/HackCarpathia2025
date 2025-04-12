extends Node2D

var score = 0
const MINIGAMES = [
	preload("res://minigames/test/test.tscn"),
	preload("res://minigames/pills/getyourmeds.tscn"),
	preload("res://minigames/police/police.tscn"),
]

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Status.visible = false
	$GrandfatherClock.get_child(0).time_ended.connect(self._on_minigame_failed)
	self._next_minigame()

func _clear_minigame():
	$"Łapa".gigapaluch(false)
	for child in $MinigameContainer.get_children():
		child.queue_free()

func _next_minigame():
	var minigame = MINIGAMES.pick_random().instantiate()
	minigame.mingame_failed.connect(self._on_minigame_failed)
	minigame.minigame_complete.connect(self._on_minigame_complete)
	self._clear_minigame()
	$MinigameContainer.add_child(minigame) 
	$GrandfatherClock.get_child(0).reset()
	
	

func _on_minigame_failed():
	self._clear_minigame()
	score -= 1
	$Status.text = "Porażka"
	$Status.visible = true
	$Score.text = "Score: %s" % score
	$GrandfatherClock.get_child(0).kill_babushka()
	await get_tree().create_timer(2.0).timeout
	$Status.visible = false
	self._next_minigame()

	

func _on_minigame_complete():
	self._clear_minigame()
	score += 1
	$Status.text = "Tak trzymaj!"
	$Status.visible = true
	$Score.text = "Score: %s" % score
	$GrandfatherClock.get_child(0).yipie()
	await get_tree().create_timer(2.0).timeout
	$Status.visible = false
	self._next_minigame()
	
	
