extends Control

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")
