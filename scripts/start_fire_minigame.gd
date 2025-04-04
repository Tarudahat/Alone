extends Control

var stick_side = 1
var friction_level = 0
var input_delay_over = true
var wood_node = preload("res://scenes/item.tscn")
var rng = RandomNumberGenerator.new()
var player_node
var max_coal_reward

@export var friction_level_time_limits: Array[float] = [3,3,4]
@export var friction_level_delays: Array[float] = [0.05,0.01,0.005]
@export var friction_level_succ_req: Array[int] = [10,15,25]
var rub_succ = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$friction_timer.start(friction_level_time_limits[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if input_delay_over:
		if Input.is_action_just_pressed("rotate_stick_left") and stick_side == 1:
			$Stick.flip_h = true
			stick_side = 0
			input_delay_over = false
			$input_delay_timer.start(friction_level_delays[friction_level])
			rub_succ+=1
			
		if Input.is_action_just_pressed("rotate_stick_right") and stick_side == 0:
			$Stick.flip_h = false
			stick_side = 1
			input_delay_over = false
			$input_delay_timer.start(friction_level_delays[friction_level])
			rub_succ+=1
			
			
	if rub_succ > friction_level_succ_req[friction_level]:
		friction_level += 1
		$GPUParticles2D.amount *=2
		rub_succ = 0
		if friction_level <= 2:
			$friction_timer.start(friction_level_time_limits[friction_level])
		
	if friction_level > 2:
		for i in rng.randi_range(1, max_coal_reward):
			var new_coal = wood_node.instantiate()
			new_coal.item_type = 3
			new_coal.position = self.position + Vector2(rng.randf_range(-100.0, 100.0),rng.randf_range(-10.0, 200.0))
			get_parent().add_child(new_coal)
			player_node.items[1] -= 1
			player_node.cutting_wood = false
			queue_free()



func _on_friction_timer_timeout() -> void:
	print("Failed make coal")
	print(rub_succ)
	player_node.cutting_wood = false
	queue_free()
	


func _on_input_delay_timer_timeout() -> void:
	input_delay_over = true
	
