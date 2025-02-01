extends Control

var handler
var cupcakeArray = []
var cupcakes_collected = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handler = get_node("/root/LevelEventHandler")
	cupcakeArray = handler.check_cupcakes()
	while cupcakeArray.size() < 25:
		cupcakeArray.append(false)
	print(cupcakeArray)
	for i in range(1, cupcakeArray.size() + 1):
		var cupcakeID = "Cupcake" + str(i)
		var cake = get_node("" + cupcakeID)
		if cupcakeArray[i - 1]:
			color_cake(cake)
			cupcakes_collected += 1
	var text = get_node("CollectionTitle")
	text.set_text("Collection (" + str(cupcakes_collected) + "/25)")

func color_cake(cake):
	cake.animation = "Unlock"


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Main_Menu.tscn")
