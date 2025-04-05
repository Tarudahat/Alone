extends AnimatedSprite2D

@export_range(0,5) var item_type = 0
var player_in_range: bool  = false
var Player_node: Node2D = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	frame=item_type
	$E_indicator.visible = false
	if player_in_range:
		$E_indicator.visible = true
		if Input.is_action_just_pressed("collect"):
			Player_node.items[item_type] +=1
			queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		Player_node = body
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = false
