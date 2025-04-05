extends Node2D

@export var speed = 200
var rng = RandomNumberGenerator.new()
var reposition: bool = true
var player_node: Node2D = null
var player_in_range: bool = false

func _physics_process(_delta):
	
	if $Fireball.position.y > $Shadow.position.y - 40:
		reposition = true
	if reposition:
		$Shadow.position = self.position + Vector2(rng.randf_range(-1000.0, 1000.0),rng.randf_range(-1000.0, 1000.0))
		$Fireball.position = $Shadow.position - Vector2(0, rng.randf_range(400.0, 550.0))
		reposition = false
		
	if player_node and player_in_range and $Fireball.position.y > $Shadow.position.y - 140:
		player_node.damage()
		reposition = true
	
func _process(delta: float) -> void:
	$Fireball.position.y += speed * delta
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
