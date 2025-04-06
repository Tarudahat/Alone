extends Area2D

var player_node: Node2D = null
var player_in_range = false
@export var destination_scene = load("res://scenes/level_1.tscn")
@export var wood_price = 40
@export var rope_price = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$raft/E_indicator.visible = false
	if player_in_range:
		$raft/E_indicator.visible = true
		if Input.is_action_just_pressed("collect"):
			if $raft.frame == 1:
				if player_node:
					Globals.items = player_node.items
					Globals.time_left = player_node.get_node("island_timer").time_left
					Globals.current_level +=1
					# add destination scene as child root
					match Globals.current_level:
						1:
							destination_scene = load("res://scenes/islands/volcano_islands/island02.tscn")
						2:
							destination_scene = load("res://scenes/islands/common_islands/common_island02.tscn")
						3:
							destination_scene = load("res://scenes/raft_minigame.tscn")
					var target_scene = destination_scene.instantiate()
					get_tree().get_root().add_child(target_scene)
					# queue wipe current scene from root
					get_tree().get_current_scene().queue_free()
					# change scene
					get_tree().set_current_scene(target_scene)
			if player_node:
				if player_node.items[1] >= wood_price and player_node.items[4] >= rope_price:
					player_node.items[1] -= wood_price
					player_node.items[4] -= rope_price
					$raft.frame = 1
			


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = true
		
