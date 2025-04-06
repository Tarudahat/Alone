extends Control

@export var destination_scene = load("res://scenes/title_screen.tscn")

func _on_timer_timeout() -> void:
	# add destination scene as child root
	var target_scene = destination_scene.instantiate()
	get_tree().get_root().add_child(target_scene)
	# queue wipe current scene from root
	get_tree().get_current_scene().queue_free()
	# change scene
	get_tree().set_current_scene(target_scene)


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play(0)
