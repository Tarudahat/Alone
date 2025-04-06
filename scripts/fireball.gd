extends Node2D

@export var speed = 200
var rng = RandomNumberGenerator.new()
var reposition: bool = true
var player_node: Node2D = null
var player_in_range: bool = false
@onready var woosh_fire_sound: AudioStreamPlayer2D = $Woosh_fire_sound
@onready var fireball_impact_sound: AudioStreamPlayer2D = $Fireball_impact_sound

func _physics_process(_delta):
	
	if $Fireball.position.y > $Shadow.position.y - 60:
		reposition = true
	if reposition:
		$Shadow.position = self.position + Vector2(rng.randf_range(-600.0, 600.0),rng.randf_range(-600.0, 600.0))
		$Fireball.position = $Shadow.position - Vector2(0, rng.randf_range(400.0, 550.0))
		reposition = false
		woosh_fire_sound.play()
		
	if player_node and player_in_range and $Fireball.position.y > $Shadow.position.y - 140:
		player_node.damage()
		reposition = true
		fireball_impact_sound.play()
	
func _process(delta: float) -> void:
	$Fireball.position.y += speed * delta
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_node = body
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_range = false
