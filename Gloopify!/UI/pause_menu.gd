extends Control

@onready var main = $"../Levels/test.tscn"

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	main.pauseMenu()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")
