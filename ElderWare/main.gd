extends Node2D

var score = 0
const MINIGAMES = [
	preload("res://minigames/test/test.tscn")
]

func _ready() -> void:
	$Status.visible = false
	self._next_minigame()

func _clear_minigame():
	for child in $MinigameContainer.get_children():
		child.queue_free()

func _next_minigame():
	var minigame = MINIGAMES.pick_random().instantiate()
	minigame.mingame_failed.connect(self._on_minigame_failed)
	minigame.minigame_complete.connect(self._on_minigame_complete)
	$MinigameContainer.add_child(minigame) 
	
	
func _on_minigame_failed(reason):
	self._clear_minigame()
	score -= 1
	$Status.text = "Porażka"
	$Status.visible = true
	$Score.text = "Score: %s" % score
	await get_tree().create_timer(2.0).timeout
	$Status.visible = false
	self._next_minigame()
	

func _on_minigame_complete():
	self._clear_minigame()
	score += 1
	$Status.text = "Tak trzymaj!"
	$Status.visible = true
	$Score.text = "Score: %s" % score
	await get_tree().create_timer(2.0).timeout
	$Status.visible = false
	self._next_minigame()
	
	
