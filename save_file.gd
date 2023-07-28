extends Node


const SAVE_FILE = "user://save_file.save"
var cal_data = {}
var id = 0


func delete_save():
	var file = FileAccess.open("user://save_file.save", FileAccess.WRITE)
	if file.file_exists(SAVE_FILE):
		file.remove("user://save_file.save")

func save_data():
	var file = FileAccess.open("user://save_file.save", FileAccess.WRITE)
	file.open(SAVE_FILE, file.WRITE)
	file.store_var(cal_data)
	file.store_var(id)

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open("user://save_file.save", FileAccess.READ)
	if file == null:
		print("File is empty.")
		return
	else:
		file.open(SAVE_FILE, FileAccess.READ)
		cal_data = file.get_var()
		id = file.get_var()
		if id == null:
			id = 0
		file.close()
		save_data()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
		get_tree().quit()
