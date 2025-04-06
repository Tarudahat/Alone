extends Area2D

@onready var raft_minigame: Control = $".."
var get_out = false

func _process(_delta: float) -> void:
	if get_out:
		# add destination scene as child root
		var target_scene = Globals.bomb_island.instantiate()
		get_tree().get_root().add_child(target_scene)
		# queue wipe current scene from root
		get_tree().get_current_scene().queue_free()
		# change scene
		get_tree().set_current_scene(target_scene)
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	print("finished")
	if body.name == "Player":
		print("finished")
		body.block_movement = false
		Globals.time_left = body.get_node("island_timer").time_left
		get_out = true
