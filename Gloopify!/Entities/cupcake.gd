extends Node2D

@export var ID: int
@onready var level = get_node("..")
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		if ID == 1:
			level.c1 = true
		elif ID == 2:
			level.c2 = true
		elif ID == 3:
			level.c3 = true
		elif ID == 4:
			level.c4 = true
		elif ID == 5:
			level.c5 = true
		if visible:
	a		$AudioStreamPlayer.play()
		hide()
		
