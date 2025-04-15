extends CharacterBody2D

@onready var movement_direction:Vector2
@onready var SPEED = 800
@onready var dmg:int = 1
var Player_node: Node2D = null
var hit_target:bool = false

func _physics_process(_delta):
	rotation_degrees += 20

	velocity = movement_direction * SPEED
	var collision = move_and_slide()
	
	if collision and not hit_target:
		for i in get_slide_collision_count():
			var collision_ = get_slide_collision(i)
			var collider = collision_.get_collider()
			
			if collider is Crab or collider is Snake:
				collider.hp -= dmg
				hit_target = true
			
			queue_free()
				
	


func _on_timer_timeout() -> void:
	queue_free()
