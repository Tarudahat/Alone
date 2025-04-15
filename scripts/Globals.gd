extends Node

const time_s_per_level: Array[int] = [5*60,5*60,3*60,1*60]
var current_level: int = 0
var items: Array[int] = [0,0,0,0,0,0]
var time_left = 0 # + per level time
var treasures_found = 0
var max_bombs = 0
var bomb_island = load("res://scenes/islands/bomb_islands/bomb_island_01.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func reset_all_values() -> void:
	current_level = 0
	items = [0,0,0,0,0,0]
	time_left = 0 # + per level time
	treasures_found = 0
	max_bombs = 0
