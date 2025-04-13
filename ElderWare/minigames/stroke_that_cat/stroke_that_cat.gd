extends Minigame

func _on_lose():
	self.mingame_failed.emit()

func _on_win():
	self.minigame_complete.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cat_cat_satisfied() -> void:
	_on_win()
	pass # Replace with function body.
