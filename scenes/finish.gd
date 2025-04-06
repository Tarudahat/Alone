extends Area2D

@onready var raft_minigame: Control = $".."

func _on_body_entered(body: Node2D) -> void:
	print("finished")
	if body.name == "Player":
		print("finished")
		raft_minigame.exit_raft()
