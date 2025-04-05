extends CharacterBody2D
class_name Player

@export var speed = 600

var target = position
var block_movement = false
var can_throw = true
var throw_target_position
var items: Array[int] = [0,0,0,0,0,0]
var wood_minigame = preload("res://scenes/start_fire_minigame.tscn")
var throwing_stone = preload("res://scenes/throw_stone.tscn")
var wood_minigame_instance = null
# shell_count
# wood_count
# sulfer_count
# coal_count
# snake_count
# stone_count

func _process(delta):
	$VBoxContainer/Label.text = "Shell: " + str(items[0])
	$VBoxContainer/Label2.text = "wood: " + str(items[1])
	$VBoxContainer/Label3.text = "sulfur: " + str(items[2])
	$VBoxContainer/Label4.text = "coal: " + str(items[3])
	$VBoxContainer/Label5.text = "Snake Rope: " + str(items[4])
	$VBoxContainer/Label6.text = "Stone: " + str(items[5])

		

func _input(event):
	if items[5] and Input.is_action_pressed("collect") and event.is_action_pressed(&"left_click"):
		throw_target_position = get_global_mouse_position()
		if can_throw:
			var new_stone = throwing_stone.instantiate()
			items[5] -= 1
			new_stone.position = self.position + position.direction_to(throw_target_position) * 200
			new_stone.movement_direction = position.direction_to(throw_target_position)
			get_parent().add_child(new_stone)
			
			can_throw = false
			$stone_cooldown.start()

		
	elif event.is_action_pressed(&"left_click") and not block_movement:
		target = get_global_mouse_position()
		
	if event.is_action_pressed("make_coal") and items[1]:
		block_movement = true
		wood_minigame_instance = wood_minigame.instantiate()
		wood_minigame_instance.position = self.position
		wood_minigame_instance.player_node = self
		
		if items[1] > 5:
			wood_minigame_instance.max_coal_reward = 5
		else:
			wood_minigame_instance.max_coal_reward = items[1]
		
		get_parent().add_child(wood_minigame_instance)

func _physics_process(_delta):
	velocity = position.direction_to(target) * speed
	if block_movement:
		velocity = Vector2.ZERO
		
	if position.distance_to(target) > 10 and not block_movement:
		move_and_slide()

func _on_stone_cooldown_timeout() -> void:
	can_throw = true
