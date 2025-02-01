extends Node

const LEVELS = 1
var saved_data = {}

func _ready() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json = JSON.new()
	var _result = json.parse(save_file.get_line())
	saved_data = json.get_data()
	
func complete_level(level, time, c1, c2, c3, c4, c5):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = saved_data
	var levelID = "level" + str(level)
	var record
	if data:
		if levelID in data:
			record = data[levelID]["record"]
	if record:
		if record > time:
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
	for i in range(1, LEVELS + 2):
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
	data["PlayerStats"] = {
		"coins": 0
		#Add other lines here as upgrades unlock
	}
	var json_data = JSON.stringify(data)
	save_file.store_line(json_data)
