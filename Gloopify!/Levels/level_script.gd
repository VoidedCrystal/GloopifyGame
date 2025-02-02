extends Node2D

const MIN_X = 0
const MAX_Y = 416

@export var LEVELID: int

var c1 = false
var c2 = false
var c3 = false
var c4 = false
var c5 = false
signal boosted(bool)

@onready var timer = get_node("Timer")
@onready var player = get_node("Player")
@onready var handler = get_node("/root/LevelEventHandler")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	var cupcakes = handler.check_cupcakes_in_level(LEVELID)
	if cupcakes:
		if cupcakes[0]:
			c1 = true
			$Cupcake1/AnimatedSprite2D.modulate.a = 0.3
		if cupcakes[1]:
			c2 = true
			$Cupcake2/AnimatedSprite2D.modulate.a = 0.3
		if cupcakes[2]:
			$Cupcake3/AnimatedSprite2D.modulate.a = 0.3
			c3 = true
		if cupcakes[3]:
			$Cupcake4/AnimatedSprite2D.modulate.a = 0.3
			c4 = true
		if cupcakes[4]:
			$Cupcake5/AnimatedSprite2D.modulate.a = 0.3
			c5 = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time = timer.time_left
	var label = get_node("Player/Camera2D/TimeLeft")
	time = snapped(time, 0.01)
	label.set_text("Time remaining: " + str(time))

func _on_area_2d_body_entered(_body: Node2D) -> void:
	toggle_player_collision.call_deferred()
	player.die()


func _on_timer_timeout() -> void:
	toggle_player_collision.call_deferred()
	player.die()
	
func toggle_player_collision():
	get_node("Player/CollisionShape2D").disabled = true


func _on_boost_panel_body_entered(_body: Node2D) -> void:
	emit_signal("boosted", true)


func _on_kill_zone_body_entered(_body: Node2D) -> void:
	toggle_player_collision.call_deferred()
	player.die()


func _on_boost_panel_body_exited(body: Node2D) -> void:
	emit_signal("boosted", true)
