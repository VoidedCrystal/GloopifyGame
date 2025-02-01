extends CharacterBody2D

const BASE_SPEED = 275.0
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 1000.0

var speed = 275.0
var current_direction = 0
var last_direction = 0
var current_directionY = 0

var dash_count = 1
var canDash = true
var dash_tick = 0
const DASH_TIME = 10
var dash_speed = 10000
var dashing = false
var dash_start = true
var dashX = 0
var dashY = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if dashing and dashY != 0:
		velocity.y = 0
		
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
		if dashing:
			velocity.x = 0
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			current_direction = 0
			speed = BASE_SPEED
	
	if Input.is_action_pressed("move-left"):
		current_direction = -1
	if Input.is_action_pressed("move-right"):
		current_direction = 1
	
	var directionY := Input.get_axis("move-up", "move-down")
	if !directionY:
		current_directionY = 0
	
	if Input.is_action_pressed("move-down"):
		current_directionY = 1
	elif Input.is_action_pressed("move-up"):
		current_directionY = -1
		
	if Input.is_action_just_pressed("dash") and canDash:
		print("Dashing!")
		dashing = true
		dash_start = true
		dash_count -= 1
		canDash = false
		
	#increase speed if necessary
	if current_direction == last_direction and speed < MAX_SPEED and is_on_floor():
		speed += 5
	elif current_direction != last_direction:
		speed = BASE_SPEED

	if dashing:
		dash_tick += 1
		velocity.x += 2 * (1.0 * dash_speed / DASH_TIME) * dashX
		velocity.y += 0.5 * (1.0 * dash_speed / DASH_TIME) * dashY
		if dash_tick >= DASH_TIME:
			dashing = false
			dash_tick = 0
	move_and_slide()

	last_direction = current_direction
	if !dashing:
		dashX = current_direction
	if !dashing:
		dashY = current_directionY
	if is_on_floor():
		dash_count = 1
		canDash = true
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
