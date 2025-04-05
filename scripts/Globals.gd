extends Node

const time_s_per_level: Array[int] = [5*60,5*60,5*60,1*60]
var current_level: int = 0
var items: Array[int] = [0,0,0,0,0,0]
var time_left = 0 # + per level time
var treasures_found = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
