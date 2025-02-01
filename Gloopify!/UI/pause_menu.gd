extends Control

var paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	pauseMenu()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
func pauseMenu():
	if paused:
		hide()
		Engine.time_scale = 1
	else:
		show()
		Engine.time_scale = 0
	
	paused = !paused
