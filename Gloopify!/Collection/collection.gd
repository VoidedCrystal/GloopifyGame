extends Control

var handler
var cupcakeArray = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handler = get_node("/root/LevelEventHandler")
	cupcakeArray = handler.check_cupcakes()
	while cupcakeArray.size() < 25:
		cupcakeArray.append(false)
	for i in range(1, cupcakeArray.size() + 1):
		var cupcakeID = "Cupcake" + str(i)
		print(cupcakeID)
		var cake = get_node("" + cupcakeID)
		if cupcakeArray[i - 1]:
			color_cake(cake)

func color_cake(cake):
	pass #Replace when sprites added
