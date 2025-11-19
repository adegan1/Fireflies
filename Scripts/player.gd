extends CharacterBody2D

@export var speed: float = 500

func _process(delta: float) -> void:
	var input_vector: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	global_position = global_position + input_vector.normalized() * delta * speed
