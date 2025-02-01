extends Control

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Options.tscn")


func _on_exit_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/LevelSelect.tscn")


func _on_cupcakes_pressed() -> void:
	get_tree().change_scene_to_file("res://Collection/collection.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Credits.tscn")
