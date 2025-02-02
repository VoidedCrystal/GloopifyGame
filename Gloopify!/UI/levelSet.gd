@tool
extends Control
class_name LevelSet

@export var level_name:="1"
@export var level_art: Texture2D
@export var level_art_grey: Texture2D
@export_file("*.tscn") var next_scene_path: String
@export var next_level_right: LevelSet
@export var next_level_left: LevelSet

var unlocked = false
var record

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Level " + str(level_name)
	$Sprite2D.texture = level_art
	$Sprite2D2.texture = level_art_grey
	$Label3.text = "[center]Beat level " + str(int(level_name) - 1) + " to unlock![/center]"
	if level_name == "1":
		$Label2.text = "Jessica is being chased by the police as she flees toward the nearest bakery. It just so happens that it sits atop a massive cliff no ordinary person could scale. Fortunately, Jessica is anything but ordinary."
	elif level_name == "2":
		$Label2.text = "A few days later, Jessica has thrown off the police. However, she is running low on power. Feeling desperate, she takes a shortcut through a sketchy area in hopes of finding a bakery."
	elif level_name == "3":
		$Label2.text = "Jessica is a natural daredevil, always showing off and taking risks to evade capture. It only makes sense, then, that she feels drawn to the junkyard, a place full of machinery, spikes, and most of all, danger. Of course, after a fun time in the junkyard, she obviously wants a cupcake to cool down."
	elif level_name == "4":
		$Label2.text = "As the source of her dash power, pastries naturally attract Jessica. One fateful day, she felt the distinct aura of a cupcake coming from a nearby laboratory full of dangerous traps and obstacles. All that mattered to Jessica, though, was the bakery at the other end of the lab."
	elif level_name == "5":
		$Label2.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(level_name)
