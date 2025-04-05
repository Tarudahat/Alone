extends CharacterBody2D

@export var speed = 600
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var state = "Idle"
var target = position
var cutting_wood = false
var items: Array[int] = [0,0,0,0]
var wood_minigame = preload("res://scenes/start_fire_minigame.tscn")
var wood_minigame_instance = null
# shell_count
# wood_count
# sulfer_count
# coal_count

func _process(delta):
	$VBoxContainer/Label.text = "Shell: " + str(items[0])
	$VBoxContainer/Label2.text = "wood: " + str(items[1])
	$VBoxContainer/Label3.text = "sulfur: " + str(items[2])
	$VBoxContainer/Label4.text = "coal: " + str(items[3])

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if not cutting_wood:
		if event.is_action_pressed(&"left_click"):
			target = get_global_mouse_position()
			state = "Walk"
		if event.is_action_pressed("make_coal") and items[1]:
			cutting_wood = true
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
	if cutting_wood:
		velocity = Vector2.ZERO
	# look_at(target)
	if position.distance_to(target) > 10 and not cutting_wood:
		move_and_slide()

func update_animation() -> void:
	animation_player.play(state + "_" + animation_direction() )

func animation_direction() -> String:
	if target == Vector2.DOWN:
		return "down"
	elif target == Vector2.UP:
		return "up"
	elif target == Vector2.LEFT:
		return "left"
	else:
		return "right"
	
