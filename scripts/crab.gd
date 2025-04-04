extends CharacterBody2D
class_name Player

@export var SPEED = 320.0
@export var NON_AGRO_SPEED = 250.0
@export var no_angry_direction = -1
var rng = RandomNumberGenerator.new()

var player_node: Node2D = null
var og_postions
var angry: bool = false
var can_dmg:bool = true

func _ready():
	og_postions = self.position

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
				for j in rng.randi_range(1, 5):
					var victim_idx = rng.randi_range(0, 3)
					if collider.items[victim_idx]:
						collider.items[victim_idx] -= 1


func _on_agro_zone_body_entered(body: Node2D) -> void:
	angry = true
	if body.name == "Player":
		player_node = body


func _on_agro_zone_body_exited(body: Node2D) -> void:
	angry = false


func _on_dmg_cooldown_timeout() -> void:
	can_dmg = true
