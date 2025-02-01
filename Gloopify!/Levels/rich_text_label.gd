extends RichTextLabel

@onready var player = get_node("..")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var velString = "Y Velocity: "+ str(player.velocity.y)+ "\nDashY: " + str(player.dashY)
	set_text(velString)
