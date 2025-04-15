extends Control

var can_go: bool = false
@export var destination_scene = load("res://scenes/title_screen.tscn")
@export var game_over_scene = load("res://scenes/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		
	$Node2D/Label.text = str(Globals.treasures_found)
	$Node2D/Label2.text = str(Globals.max_bombs)
	
	if int(int(Globals.time_left)%60) > 9:
		$Node2D/Label3.text = str(int(Globals.time_left/60.0)) +\
		 ":" +str(int(int(Globals.time_left)%60))
	else:
		$Node2D/Label3.text = str(int(Globals.time_left/60.0)) +\
		 ":0" +str(int(int(Globals.time_left)%60))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Globals.max_bombs < 4:
		# add destination scene as child root
		var target_scene = game_over_scene.instantiate()
		get_tree().get_root().add_child(target_scene)
		# queue wipe current scene from root
		get_tree().get_current_scene().queue_free()
		# change scene
		get_tree().set_current_scene(target_scene)
	if can_go:
		if (Input.is_action_just_pressed("collect") or Input.is_action_just_pressed("left_click")):
			Globals.reset_all_values()
			# add destination scene as child root
			var target_scene = destination_scene.instantiate()
			get_tree().get_root().add_child(target_scene)
			# queue wipe current scene from root
			get_tree().get_current_scene().queue_free()
			# change scene
			get_tree().set_current_scene(target_scene)



func _on_timer_timeout() -> void:
	can_go = true


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play(0)
