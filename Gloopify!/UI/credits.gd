extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")
