extends StaticBody2D

@onready var raft_minigame: Control = $".."


func _process(delta: float) -> void:
	pass
	
func _area_entered(body) -> void:
	if body.name == "Player":
		raft_minigame.exit_raft()
