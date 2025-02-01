extends CharacterBody2D

const BASE_SPEED = 275.0
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 1000.0

var speed = 275.0
var current_direction = 0
var last_direction = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		current_direction = 0
		speed = BASE_SPEED
	
	if Input.is_action_just_pressed("move-left"):
		current_direction = -1
	elif Input.is_action_just_pressed("move-right"):
		current_direction = 1
		
	#increase speed if necessary
	if current_direction == last_direction and speed < MAX_SPEED:
		speed += 5
	elif current_direction != last_direction:
		speed = BASE_SPEED

	move_and_slide()

	last_direction = current_direction
