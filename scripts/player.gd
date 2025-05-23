extends CharacterBody2D
class_name Player

@export var speed = 600
@onready var walk_sound: AudioStreamPlayer2D = $Walk_sound
@onready var damage_sound: AudioStreamPlayer2D = $Damage_sound
@onready var throw_sound: AudioStreamPlayer2D = $Throw_sound
@onready var item_collect_sound: AudioStreamPlayer2D = $Item_collect_sound
@onready var wave_sounds : AudioStreamPlayer2D = $Wave_sounds

var target = position
@export var block_movement = true
var can_throw = true
var throw_target_position
var items: Array[int] = [0,0,0,0,0,0]
var rng = RandomNumberGenerator.new()
var wood_minigame = preload("res://scenes/start_fire_minigame.tscn")
var throwing_rock = preload("res://scenes/throw_stone.tscn")
var wood_minigame_instance = null
@onready var current_timer = $island_timer
# shell_count
# wood_count
# sulfer_count
# coal_count

func _ready():
	self.items = Globals.items
	self.get_node("island_timer").start(Globals.time_left + Globals.time_s_per_level[Globals.current_level])


func damage():
	for j in rng.randi_range(1, 5):
		var victim_idx = rng.randi_range(0, 5)
		if items[victim_idx]:
			items[victim_idx] -= 1
	damage_sound.play()


func _process(_delta):
	$UI/items_ui/VBoxContainer/Label.text = "Shells: " + str(items[0])
	$UI/items_ui/VBoxContainer/Label2.text = "Wood: " + str(items[1])
	$UI/items_ui/VBoxContainer/Label3.text = "Sulfur: " + str(items[2])
	$UI/items_ui/VBoxContainer/Label4.text = "Coal: " + str(items[3])
	$UI/items_ui/VBoxContainer/Label5.text = "\"Rope\": " + str(items[4])
	$UI/items_ui/VBoxContainer/Label6.text = "Stones: " + str(items[5])
	#$Sprite.play(animation_direction())
	if int(int(current_timer.time_left)%60) > 9:
		$UI/items_ui/death_timer_ui/Label7.text = str(int(current_timer.time_left/60)) +\
		 " : " +str(int(int(current_timer.time_left)%60))
	else:
		$UI/items_ui/death_timer_ui/Label7.text = str(int(current_timer.time_left/60)) +\
		 " : 0" +str(int(int(current_timer.time_left)%60))
		

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if items[5] and event.is_action_pressed(&"right_click"):
		if can_throw:
			throw_sound.play()
			items[5]-=1
			var rock_instance = throwing_rock.instantiate()
			throw_target_position = get_global_mouse_position()
			rock_instance.movement_direction = position.direction_to(throw_target_position)
			rock_instance.position = self.position + rock_instance.movement_direction*150
			get_parent().add_child(rock_instance)
			$throw_cooldown.start()
			can_throw = false
			
	elif event.is_action_pressed(&"left_click") and not block_movement:
		target = get_global_mouse_position()
		var movement_dir = position.direction_to(target)
		var a = 0.95
		if (movement_dir.dot(Vector2(1,1)))>a:
			$Sprite.frame = 1
		if (movement_dir.dot(Vector2(1,-1)))>a:
			$Sprite.frame = 3
		if (movement_dir.dot(Vector2.RIGHT))>a:
			$Sprite.frame = 2
		if (movement_dir.dot(Vector2.UP))>a:
			$Sprite.frame = 4
		if (movement_dir.dot(Vector2(-1,-1)))>a:
			$Sprite.frame = 5
		if (movement_dir.dot(Vector2(-1,1)))>a:
			$Sprite.frame = 7
		if (movement_dir.dot(Vector2.LEFT))>a:
			$Sprite.frame = 6
		if (movement_dir.dot(Vector2.DOWN))>a:
			$Sprite.frame = 0
		walk_sound.play()
	if event.is_action_pressed("make_coal") and items[1] and not block_movement:
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

func _on_throw_cooldown_timeout() -> void:
	can_throw = true


func _on_island_timer_timeout() -> void:
	var target_scene = load("res://scenes/game_over.tscn").instantiate()
	get_tree().get_root().add_child(target_scene)
	# queue wipe current scene from root
	get_tree().get_current_scene().queue_free()
	# change scene
	get_tree().set_current_scene(target_scene)


func _on_wave_sounds_finished() -> void:
	$Wave_sounds.play(0)


func _on_movement_bug_timer_timeout() -> void:
	block_movement = false
	target = self.position
