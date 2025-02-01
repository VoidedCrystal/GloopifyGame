@tool
extends Control
class_name LevelSet

@export var level_name:="1"
@export_file("*.tscn") var next_scene_path: String
@export var next_level_right: LevelSet
@export var next_level_left: LevelSet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Level " + str(level_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(level_name)
