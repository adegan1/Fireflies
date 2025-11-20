extends CharacterBody2D


# ---------- Initial Variables ----------
# Movement Tuning
@export var base_max_speed: float = 700.0
@export var acceleration: float = 2000.0
@export var friction: float = 1000.0
@export var momentum_turn_strength: float = 6.0  # Higher = snappier turns


# ---------- Internal State ----------
var input_direction := Vector2.ZERO
var noise := FastNoiseLite.new()
var time_passed := 0.0

func _ready() -> void:
	# Seed noise for per-player natural variation
	noise.seed = randi()

func _physics_process(delta: float) -> void:
	_get_input()
	_apply_inertia(delta)
	_apply_momentum(delta)

	# Move the player using velocity property
	move_and_slide()
	


# ---------- Input Handling ----------
func _get_input() -> void:
	input_direction = Vector2.ZERO
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_direction = input_direction.normalized()


# ---------- Speed Handling ----------
func _get_current_max_speed() -> float:
	# Smoothly lerp to max speed
	return lerp(base_max_speed, 200.0, 0.5)


# ---------- Intertia Force ----------
func _apply_inertia(delta: float) -> void:
	if input_direction.length() > 0:
		# Accelerate toward desired direction
		var target_velocity = input_direction * _get_current_max_speed()
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		# Slow down gradually
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)


# ---------- Momentum Preservation ----------
func _apply_momentum(delta: float) -> void:
	# Smoothly curve velocity toward input direction instead of snapping
	if input_direction.length() > 0:
		var desired_velocity = input_direction * velocity.length()
		velocity = velocity.lerp(desired_velocity, delta * momentum_turn_strength)
