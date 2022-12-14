extends Node

var timer: Timer

var state: Dictionary = {
	"animation_speed": 2.5,
	"zoom_const": .75,
	"interact_speed": .2,
	
	"workbench": {
		"body": {
			"is_legend_open": false
		}
	}
}

func save(data, file_name: String):
	var f := File.new()
	f.open("user://" + file_name + ".save", File.WRITE)
	f.store_buffer(var2bytes(data))
	f.close()

func load_save(file_name: String, var_name: String):
	var f := File.new()
	if f.file_exists("user://" + file_name + ".save"):
		f.open("user://" + file_name + ".save", File.READ)
		var s = bytes2var(f.get_buffer(f.get_len()))
		self[var_name] = s
	f.close()

func _ready():
	load_save("state", "state")
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.connect("timeout", self, "_timeout")
	self.add_child(timer)

func _timeout():
	save(state, "state")
