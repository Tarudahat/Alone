extends Control

#@export var destination_scene = load("res://scenes/raft_minigame.tscn")
@export var destination_scene = load("res://scenes/level_1.tscn")
@onready var minigame_timer: Timer = $Minigame_timer
@onready var raft: CharacterBody2D = $Raft
@onready var player: Player = $Player

var player_node

func _ready():
	player.current_timer = minigame_timer
	minigame_timer.start()

func _process(delta: float) -> void:
	player.position = raft.position

func _on_minigame_timer_timeout():
	pass

func exit_raft() -> void:
	player.block_movement = false
	# add destination scene as child root
	var target_scene = Globals.bomb_island.instantiate()
	get_tree().get_root().add_child(target_scene)
	# queue wipe current scene from root
	get_tree().get_current_scene().queue_free()
	# change scene
	get_tree().set_current_scene(target_scene)
	#
	queue_free()
