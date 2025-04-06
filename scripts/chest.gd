extends Area2D

var treasure_counted: bool = false

var player_in_range: bool = false
var player_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$E_indicator.visible = false
	
	if player_in_range:
		if $AnimatedSprite2D.frame < 3:
			$E_indicator.visible = true
		else:
			if not treasure_counted:
				Globals.treasures_found += 1
				treasure_counted = true
	
	if Input.is_action_just_pressed("collect"):
		if player_in_range and player_node and $AnimatedSprite2D.frame < 3:
			if $AnimatedSprite2D.frame == 1:
				$AudioStreamPlayer2D.play(0)
			$AnimatedSprite2D.frame += 1


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
