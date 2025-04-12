extends Minigame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Lose.pressed.connect(self._on_lose)
	$Win.pressed.connect(self._on_win)

func _on_lose():
	self.mingame_failed.emit()

func _on_win():
	self.minigame_complete.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
