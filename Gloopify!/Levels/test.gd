extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var pause_menu = $"Pause Menu"
var paused = false;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
	
	
	
