extends Sprite2D

@onready var hit_tree_sound: AudioStreamPlayer2D = $Hit_tree_sound
@onready var break_tree_sound: AudioStreamPlayer2D = $Break_tree_sound

var player: Node2D = null
var player_in_range: bool = false
var mouse_in_hitbox: bool = false
var wood_node = preload("res://scenes/item.tscn")
var rng = RandomNumberGenerator.new()
@export var hp: int = 20
var max_hp: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_hp = hp
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ProgressBar.value = hp;
	$ProgressBar.visible = false;
	$click_indicator.visible = false
	if player_in_range:
		$click_indicator.visible = true
		if hp < max_hp:
			$ProgressBar.visible = true;
		if mouse_in_hitbox:
			if Input.is_action_just_pressed("left_click"):
				if $Timer.time_left <= 0:
					player.block_movement = true
				$Timer.start()
				hp-=1
				hit_tree_sound.play()
					
	if hp == 0:
		break_tree_sound.play()
		player.block_movement = false	
		for i in rng.randi_range(2, 4):
			var new_wood = wood_node.instantiate()
			new_wood.item_type = 1
			new_wood.position = self.position + Vector2(rng.randf_range(-100.0, 100.0),rng.randf_range(-10.0, 200.0))
			get_parent().add_child(new_wood)

		queue_free()
				

func _on_punch_hitbox_mouse_entered() -> void:
	mouse_in_hitbox = true


func _on_punch_hitbox_mouse_exited() -> void:
	mouse_in_hitbox = false


func _on_timer_timeout() -> void:
	player.block_movement = false


func _on_range_checker_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player = body
		player_in_range = true


func _on_range_checker_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = false


func _on_range_checker_mouse_exited() -> void:
	mouse_in_hitbox = false
	if player:
		player.block_movement = false
	$Timer.stop()
	
