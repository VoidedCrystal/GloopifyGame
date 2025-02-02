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

var dying = false
var dying2 = false
var death_timer = 0
const DEATH_TIME = 20

var win = false
var win_scene = false

func _physics_process(delta: float) -> void:
	if not win or not is_on_floor():
		# Add the gravity.
		if dashing and dashY != 0:
			velocity.y = 0
			
		if not is_on_floor():
			if is_on_wall():
				velocity += get_gravity() * delta * 0.4
			else:
				velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$AnimationPlayer.play("Jump")
			
			
			
		

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
			
		if Input.is_action_just_pressed("jump") and not is_on_floor() and is_on_wall():
			var jumpdir = get_wall_normal()
			velocity.x = jumpdir.x * speed * 7
			velocity.y = JUMP_VELOCITY
			
		
		if Input.is_action_pressed("move-left"):
			current_direction = -1
			get_node("AnimatedSprite2D").flip_h = true
		if Input.is_action_pressed("move-right"):
			current_direction = 1
			get_node("AnimatedSprite2D").flip_h = false
			
		
		var directionY := Input.get_axis("move-up", "move-down")
		if !directionY:
			current_directionY = 0
		
		if Input.is_action_pressed("move-down"):
			current_directionY = 1
		elif Input.is_action_pressed("move-up"):
			current_directionY = -1
			
		if Input.is_action_just_pressed("dash") and canDash:
			dashing = true
			dash_start = true
			dash_count -= 1
			canDash = false
			$AnimationPlayer.play("Dash")
			
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
		
		if dying or dying2:
			velocity.x = 0
			velocity.y = 1000
		
		move_and_slide()

		last_direction = current_direction
		if !dashing:
			dashX = current_direction
		if !dashing:
			dashY = current_directionY
		if is_on_floor():
			dash_count = 1
			canDash = true
			
		
		if is_on_wall():
			var jumpdir = get_wall_normal()
			$AnimationPlayer.play("Climb")
			
			$AnimatedSprite2D.offset.x = 5 * jumpdir.x * -1
			if jumpdir.x == -1:
				get_node("AnimatedSprite2D").flip_h = false
			else:
				get_node("AnimatedSprite2D").flip_h = true		
		else:
			$AnimatedSprite2D.offset.x = 0
			
		if velocity.y > 0 and not is_on_wall() and dashing == false:
			$AnimationPlayer.play("Fall")
			
		
		if dashing == false and velocity.x != 0 and $AnimationPlayer.current_animation != "Jump" and is_on_floor() and not is_on_wall():
			$AnimationPlayer.play("Run")
		
		if velocity.x == 0 and velocity.y == 0 and is_on_floor():
			$AnimationPlayer.play("Idle")
		
		if Input.is_action_just_pressed("reset") and not dying and not dying2:
			get_node("CollisionShape2D").disabled = true
			die()
		
		if dying:
			death_timer += 1
			get_node("Camera2D/DeathScreen").modulate.a += 1.0 / DEATH_TIME
			if death_timer >= DEATH_TIME:
				dying = false
				dying2 = true
		
		if dying2:
			death_timer -= 1
			get_node("Camera2D/DeathScreen").modulate.a -= 1.0 / DEATH_TIME
			if death_timer <= 0:
				dying2 = false
				get_node("Camera2D/DeathScreen").hide()
				get_tree().reload_current_scene()
	elif !win_scene:
		win_level()

func die():
	get_node("Camera2D/DeathScreen").show()
	if get_node("../AudioStreamPlayer"):
		get_node("../AudioStreamPlayer").stop()
	$DeathSound.play()
	dying = true

func win_level():
	win_scene = true
	$AnimationPlayer.play("Dance")
	$DanceTimer.start(7.5)


func _on_dance_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://UI/LevelSelect.tscn")
