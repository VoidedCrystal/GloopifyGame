extends Camera2D

var minx = 0
var maxy = 0
var player
@onready var timer = get_node("TimeLeft")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level = get_node("../..")
	minx = level.MIN_X
	maxy = level.MAX_Y
	player = get_node("..")
	if player.global_position.x <= minx + 240:
		offset.x = minx + 240 - player.global_position.x
	else:
		offset.x = 0
	if player.global_position.y >= maxy - 135:
		offset.y = maxy - 135 - player.global_position.y
	else:
		offset.y = 0
	timer.position.x = offset.x - 235
	timer.position.y = offset.y - 125


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if player.global_position.x <= minx + 240:
		offset.x = minx + 240 - player.global_position.x
	else:
		offset.x = 0
	if player.global_position.y >= maxy - 135:
		offset.y = maxy - 135 - player.global_position.y
	else:
		offset.y = 0
	timer.position.x = offset.x - 235
	timer.position.y = offset.y - 125
