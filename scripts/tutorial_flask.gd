extends Sprite2D
class_name tutorial_flask

@export var texture_ = load("res://assets/tutorials/tutorial.png")
var player_in_range: bool = false
var player_node: Node2D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$E_indicator.visible = false
	if player_in_range:
		$E_indicator.visible = true
		if player_node:
			if Input.is_action_just_pressed("collect"):
				player_node.get_node("img_ui").texture = texture_
			if Input.is_action_just_pressed("left_click"):
				player_node.get_node("img_ui").texture = null


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	if player_node:
		player_node.get_node("img_ui").texture = null
	
