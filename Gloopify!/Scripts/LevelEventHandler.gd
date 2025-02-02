extends Node

const LEVELS = 5
var saved_data = {}

func _ready() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	if save_file:
		var json = JSON.new()
		var _result = json.parse(save_file.get_line())
		saved_data = json.get_data()
	else:
		initialize_save_file()
		
func initialize_save_file():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = {
		"level1": {
			"clear": true,
			"record": -1,
			"c1": false,
			"c2": false,
			"c3": false, 
			"c4": false,
			"c5": false
		}
	}
	var json_data = JSON.stringify(data)
	save_file.store_line(json_data)
	
func complete_level(level, time, c1, c2, c3, c4, c5):
	print(time)
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = saved_data
	var levelID = "level" + str(level)
	var record
	if data:
		if levelID in data:
			record = data[levelID]["record"]
	if record:
		if record > time and record > 0:
			record = time
		elif record < 0:
			record = time
	data[levelID] = {
		"clear": true,
		"record": record,
		"c1": c1,
		"c2": c2,
		"c3": c3, 
		"c4": c4,
		"c5": c5
	}
	var json_data = JSON.stringify(data)
	save_file.store_line(json_data)
	
func reset_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = {}
	for i in range(1, LEVELS + 1):
		var levelID = "level" + str(i)
		data[levelID] = {
			"clear": false,
			"record": -1,
			"c1": false,
			"c2": false,
			"c3": false, 
			"c4": false,
			"c5": false
		}
	var json_data = JSON.stringify(data)
	save_file.store_line(json_data)
	
func check_cupcakes():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var _result = json.parse(save_file.get_line())
	var data = json.get_data()
	var cupcakes = []
	for i in range(1, LEVELS + 2):
		var levelID = "level" + str(i)
		if levelID in data:
			for j in range(1, 6):
				var cupcakeID = "c" + str(j)
				if cupcakeID in data[levelID]:
					cupcakes.append(data[levelID][cupcakeID])
	return cupcakes

func check_cupcakes_in_level(level):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var _result = json.parse(save_file.get_line())
	var data = json.get_data()
	var cupcakes = []
	var levelID = "level" + str(level)
	if levelID in data:
		for j in range(1, 6):
			var cupcakeID = "c" + str(j)
			if cupcakeID in data[levelID]:
				cupcakes.append(data[levelID][cupcakeID])
	return cupcakes

func unlock_levels():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var _result = json.parse(save_file.get_line())
	var data = json.get_data()
	if "level4" in data:
		if "clear" in data["level4"]:
			if data["level4"]["clear"] == true:
				return 5
	if "level3" in data:
		if "clear" in data["level3"]:
			if data["level3"]["clear"] == true:
				return 4
	if "level2" in data:
		if "clear" in data["level2"]:
			if data["level2"]["clear"] == true:
				return 3
	if "level1" in data:
		if "clear" in data["level1"]:
			if data["level1"]["clear"] == true:
				return 2
	return 1

func get_record_time(level):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var _result = json.parse(save_file.get_line())
	var data = json.get_data()
	var levelID = "level" + str(level)
	if levelID in data:
		if "clear" in data[levelID]:
			if data[levelID]["clear"] == true and "record" in data[levelID]:
				if data[levelID]["record"] > 0:
					return data[levelID]["record"]
	return
