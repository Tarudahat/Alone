extends Control


@onready var minigame_timer: Timer = $Minigame_timer


func _ready():
	minigame_timer.start()

func _on_minigame_timer_timeout():
	pass
