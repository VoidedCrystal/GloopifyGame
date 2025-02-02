extends Control

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")


func _on_reset_pressed() -> void:
	var rect = get_node("ColorRect")
	rect.show()
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")

func _on_yes_pressed() -> void:
	var handler = get_node("/root/LevelEventHandler")
	handler.reset_data()
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")


func _on_no_pressed() -> void:
	var rect = get_node("ColorRect")
	rect.hide()
