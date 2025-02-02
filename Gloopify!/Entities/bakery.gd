extends Node2D

var levelID = 0
@onready var handler = get_node("/root/LevelEventHandler")
@onready var level = get_node("..")
@onready var player = get_node("../Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levelID = level.LEVELID


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		get_node("../AudioStreamPlayer").stop()
		player.win = true
		$Timer.start()
		print("Timer started")
		

func _on_timer_timeout() -> void:
	
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	get_node("../Player/Camera2D/TimeLeft").hide()
	$Confetti.show()
	$Confetti2.show()
	$Confetti3.show()
	$Confetti4.show()
	
	var timer = get_node("../Timer")
	var time = timer.wait_time - timer.time_left
	timer.stop()
	handler.complete_level(levelID, time, level.c1, level.c2, level.c3, level.c4, level.c5)
	
