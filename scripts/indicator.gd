extends Sprite2D

@export var speed = 1
@onready var og_position = self.position
var x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = og_position + Vector2(0, sin(x)*15)
	x += 1 * speed * delta
