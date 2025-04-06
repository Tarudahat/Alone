extends Control


@onready var minigame_timer: Timer = $Minigame_timer
@onready var raft: CharacterBody2D = $Raft
@onready var player: Player = $Player

var player_node

func _ready():
	minigame_timer.start()

func _process(delta: float) -> void:
	player.position = raft.position

func _on_minigame_timer_timeout():
	pass
