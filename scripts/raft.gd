extends CharacterBody2D
@export var speed = 400
@export var vertical_speed := 300.0  # constant upward motion
@onready var finish: StaticBody2D = $"../finish"

func _ready() -> void:
	pass
	

func _physics_process(delta) -> void:
	var direction = 0

	# Handle A/D input
	if Input.is_action_pressed("left"):  # default: A
		direction -= 1
	if Input.is_action_pressed("right"): # default: D
		direction += 1

	# Apply movement
	velocity.x = direction * speed
	velocity.y = -vertical_speed  # Always going up

	move_and_slide()
