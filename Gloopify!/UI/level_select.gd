extends Control
class_name LevelSelect

@onready var current_level: LevelSet = $LevelSet
var current_world: int = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left") and current_level.next_level_left:
		current_level.hide()
		current_level = current_level.next_level_left
		current_level.show()
	if event.is_action_pressed("ui_right") and current_level.next_level_right:
		current_level.hide()
		current_level = current_level.next_level_right
		current_level.show()
	if event.is_action_pressed("ui_accept"):
		if current_level.next_scene_path:
			get_tree().change_scene_to_file(current_level.next_scene_path)
			
			
