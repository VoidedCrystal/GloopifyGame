extends Control
class_name LevelSelect

@onready var current_level: LevelSet = $LevelSet1
@onready var handler = get_node("/root/LevelEventHandler")
var current_world: int = 0

func _ready() -> void:
	var highest_level_unlocked = handler.unlock_levels()
	for i in range(1, highest_level_unlocked + 1):
		var lset = get_node("LevelSet" + str(i) + "/Sprite2D")
		lset.show()
		get_node("LevelSet" + str(i)).unlocked = true
	for i in range(1, highest_level_unlocked):
		var record = handler.get_record_time(i)
		if record:
			record = snapped(record, 0.01)
			var record_display = get_node("LevelSet" + str(i) + "/Label4")
			var record_rect = get_node("LevelSet" + str(i) + "/TextureRect4")
			record_display.text = "Record Time: " + str(record) + "s"
			record_display.show()
			record_rect.show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move-left") and current_level.next_level_left:
		current_level.hide()
		current_level = current_level.next_level_left
		current_level.show()
	if event.is_action_pressed("move-right") and current_level.next_level_right:
		current_level.hide()
		current_level = current_level.next_level_right
		current_level.show()
	if event.is_action_pressed("accept"):
		if current_level.next_scene_path and current_level.unlocked:
			get_tree().change_scene_to_file(current_level.next_scene_path)
	if Input.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")
			
			
