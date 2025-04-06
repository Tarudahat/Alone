extends CharacterBody2D
class_name Crab

<<<<<<< HEAD
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var walk_sound: AudioStreamPlayer2D = $Walk_sound
=======
@onready var animation_player: AnimationPlayer = $AnimationPlayer
>>>>>>> 5573a16 (sounds about done.)

@export var SPEED = 320.0
@export var NON_AGRO_SPEED = 250.0
@export var no_angry_direction = -1
@export var hp = 5
var rng = RandomNumberGenerator.new()

var player_node: Node2D = null
var og_postions
var angry: bool = false
var can_dmg:bool = true

func _ready():
	og_postions = self.position
	#animation_player.play("Walk")

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if angry:
		if player_node:
			velocity = position.direction_to(player_node.position) * SPEED
	else:
		if position.distance_to(og_postions) > 200:
			velocity = position.direction_to(og_postions) * NON_AGRO_SPEED
			no_angry_direction *= -1
		else:
			if $ray_left.is_colliding():
				no_angry_direction = 1
			if $ray_right.is_colliding():
				no_angry_direction = -1
			velocity = Vector2(no_angry_direction, 0) * NON_AGRO_SPEED
	
	var collision = move_and_slide()
	
	if collision:
		for i in get_slide_collision_count():
			var collision_ = get_slide_collision(i)
			var collider = collision_.get_collider()
			if collider.name == "Player" and can_dmg:
				$dmg_cooldown.start()
				can_dmg = false
				player_node.damage()

						
	if hp <= 0:
		queue_free()
		
func _on_agro_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		angry = true
		player_node = body


func _on_agro_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		angry = false


func _on_dmg_cooldown_timeout() -> void:
	can_dmg = true
