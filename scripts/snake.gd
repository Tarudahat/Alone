extends CharacterBody2D
class_name Snake

@export var SPEED = 320.0
@export var NON_AGRO_SPEED = 250.0
@export var no_angry_direction = -1
@export var hp = 3
var rng = RandomNumberGenerator.new()
var snake_rope = preload("res://scenes/item.tscn")

@onready var next_idle_target: Vector2 = self.position
var player_node: Node2D = null
var og_position
var angry: bool = false
var can_dmg:bool = true

func _ready():
	og_position = self.position

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if angry:
		if player_node:
			velocity = position.direction_to(player_node.position) * SPEED
	else:
		if position.distance_to(og_position) > 350:
			velocity = position.direction_to(og_position) * NON_AGRO_SPEED
		elif position.distance_to(next_idle_target) > 50:
			velocity = position.direction_to(next_idle_target) * NON_AGRO_SPEED
			
	look_at(self.position + velocity)
	var collision = move_and_slide()
	if collision:
		for i in get_slide_collision_count():
			var collision_ = get_slide_collision(i)
			var collider = collision_.get_collider()
			if collider is Player and can_dmg:
				$dmg_cooldown.start()
				can_dmg = false
				player_node.damage()

	if hp <= 0:
		for i in rng.randi_range(2, 4):
			var snake_rope_instance = snake_rope.instantiate()
			snake_rope_instance.item_type = 4
			snake_rope_instance.position = self.position + Vector2(rng.randf_range(-100.0, 100.0),rng.randf_range(-10.0, 200.0))
			get_parent().add_child(snake_rope_instance)
		queue_free()

func _on_agro_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		angry = true
		player_node = body


func _on_agro_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		angry = false


func _on_dmg_cooldown_timeout() -> void:
	can_dmg = true


func _on_idle_timer_timeout() -> void:
	next_idle_target = og_position + Vector2(rng.randf_range(-250,250), rng.randf_range(-250,250))
	$idle_timer.start()
