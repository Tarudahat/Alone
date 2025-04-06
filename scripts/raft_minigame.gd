extends Control

#@export var destination_scene = load("res://scenes/raft_minigame.tscn")
@export var destination_scene = load("res://scenes/level_1.tscn")
@onready var minigame_timer: Timer = $Minigame_timer
@onready var raft: CharacterBody2D = $Raft
@onready var player: Player = $Player

var player_node

func _ready():
	player.get_node("island_timer").start(Globals.time_left + 1.5*60.0)
	$Player.get_node("Sprite").frame = 4

func _process(_delta: float) -> void:
	player.position = raft.position + Vector2(0,-50)
