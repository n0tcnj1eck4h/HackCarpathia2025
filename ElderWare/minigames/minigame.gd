extends Node
class_name Minigame

enum FailureReason{TIME, IDIOT}

signal mingame_failed(reason: FailureReason)
signal minigame_complete
