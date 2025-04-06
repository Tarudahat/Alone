extends Area2D


var player_in_range: bool = false
var player_node = null

@export var coal_cost = 6
@export var sulfur_cost = 2
@export var shell_cost = 6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_in_range and player_node:
		if Input.is_action_just_pressed("collect"):
			if player_node.items[3] >= coal_cost and\
				player_node.items[2] >= sulfur_cost and\
				player_node.items[0] >= shell_cost :
				$AnimatedSprite2D.modulate = Color(Color.WHITE, 100)
				var max_bombs = floori(min(player_node.items[3]/coal_cost,player_node.items[2]/sulfur_cost,player_node.items[0]/shell_cost))
				player_node.items[3] -= coal_cost * max_bombs
				player_node.items[2] -= sulfur_cost * max_bombs
				player_node.items[0] -= shell_cost * max_bombs
				$AnimatedSprite2D.scale.x = 1.0 + float(max_bombs)/10
				$AnimatedSprite2D.scale.y = 1.0 + float(max_bombs)/10
			


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
