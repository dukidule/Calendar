extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var labelText = get_node("Container/DateAndMonth")
onready var background_color = get_node("Background")
onready var rect = get_node("Container/DaysOfTheWeek/Friday/ReferenceRect")


var current_time = OS.get_datetime()
var on_open_month = current_time.month
var on_open_weekday = current_time.weekday
var on_open_date = current_time.day
var on_open_year = current_time.year
var current_month = ""
var current_weekday = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	_get_current_month(on_open_month)
	_get_current_weekday(on_open_weekday)
	_day_cells()
	labelText.text = current_weekday +", " + current_month +" " + str(on_open_date)
	
#	print(current_weekday)
#	print(current_time)
	
	pass # Replace with function body.



func _get_current_month(month: int):
	var check_month = month;
	match check_month:
		1:
			current_month = "January"
		2:
			current_month = "February"
		3:
			current_month = "March"
		4:
			current_month = "April"
		5:
			current_month = "May"
		6:
			current_month = "June"
		7:
			current_month = "July"
		8:
			current_month = "August"
		9:
			current_month = "September"
		10:
			current_month = "October"
		11:
			current_month = "November"
		12:
			current_month = "December"
		_: 
			print("Month not found.")



func _get_current_weekday(weekday: int):
	var day = weekday
	match day:
		1:
			current_weekday = "Monday"
		2:
			current_weekday = "Tuesday"
		3:
			current_weekday = "Wednesday"
		4:
			current_weekday = "Thursday"
		5:
			current_weekday = "Friday"
		6:
			current_weekday = "Saturday"
		7:
			current_weekday = "Sunday"
		_: 
			print("Out of bounds.")

var day_cells = []
var date

func _day_cells():
	var all_cells = []
	var cell_index
	
	day_cells.append(get_node("Week1").get_children())
	day_cells.append(get_node("Week2").get_children())
	day_cells.append(get_node("Week3").get_children())
	day_cells.append(get_node("Week4").get_children())
	day_cells.append(get_node("Week5").get_children())
	day_cells.append(get_node("Week6").get_children())
	date = on_open_date
	
	var finding_cell
	var lookup_cell
	
	if date%7>=0 && date%7 < on_open_weekday:
		
		finding_cell = day_cells[date/7]
		finding_cell[on_open_weekday-1].label.text = str(date)
		lookup_cell = finding_cell[on_open_weekday-1]
		
	elif date%7>=0 && date % 7 > on_open_weekday:
		finding_cell = day_cells[date/7+1]
		finding_cell[on_open_weekday-1].label.text = str(date)
		lookup_cell = finding_cell[on_open_weekday-1]
		
	for cells in day_cells:
		for child in cells:
			var cell = child
			all_cells.append(cell)
	cell_index = all_cells.find(lookup_cell)
	while(date<31):
		date+=1
		var current_cell = all_cells[cell_index+1]
		current_cell.label.text = str(date)
		cell_index+=1
		
	while(date>=31 && cell_index<41):
		date+=1
		var current_cell = all_cells[cell_index+1]
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		cell_index+=1
	
	cell_index = all_cells.find(lookup_cell)
	date = on_open_date
	
	while(date>1 && date<=31):
		date-=1
		var current_cell = all_cells[cell_index-1]
		current_cell.label.text = str(date)
		cell_index-=1
		
	while(date<=1 && cell_index>=0):
		print("asd")
		date-=1
		print(date)
		print(cell_index)
		var current_cell = all_cells[cell_index-1]
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		cell_index-=1

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		get_tree().get_root().set_transparent_background(false)
		self.modulate.a = 1
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().get_root().set_transparent_background(true)
		self.modulate.a = 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
