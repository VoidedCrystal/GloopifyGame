extends Node2D

const MIN_X = 0
const MAX_Y = 416

@onready var timer = get_node("Timer")
@onready var player = get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time = timer.time_left
	var label = get_node("Player/Camera2D/TimeLeft")
	time = snapped(time, 0.01)
	label.set_text("Time remaining: " + str(time))

func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_node("Player/CollisionShape2D").disabled = true
	player.die()


func _on_timer_timeout() -> void:
	get_node("Player/CollisionShape2D").disabled = true
	player.die()
