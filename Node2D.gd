extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var label_text = get_node("Container/LabelScript/DateAndMonth")
@onready var get_label_text = get_node("Container/LabelScript")
@onready var background_color = get_node("Background")
@onready var rect = get_node("Container/DaysOfTheWeek/Friday/ReferenceRect")



var current_time = Time.get_datetime_dict_from_system()
#current date values
var on_open_month = current_time.month
var on_open_weekday = current_time.weekday
var on_open_date = 1
var on_open_year = current_time.year

#labels
var current_month_label = ""
var current_weekday_label = ""
#used variables
var number_of_days = 1
var current_month = on_open_month

# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_days = _get_current_month(current_month)
	_get_current_weekday_label(on_open_weekday)
	_day_cells(on_open_month, on_open_weekday, on_open_date)
	current_month_label = get_label_text._get_current_month_label(current_month)
	label_text.text = current_month_label + " " + str(on_open_year)

	
#add ST, ND, RD (First, second third) 
#	print(current_weekday)
#	print(current_time)
	
	pass # Replace with function body.



func _get_current_month(month: int) -> int:
	var days_count = 0
	match month:
		1:
			days_count = 31
			return days_count
		2:
			if on_open_year%4 == 0 || on_open_year%100 == 0:
				days_count = 29
			else:
				days_count = 28
			return days_count
		3:
			days_count = 31
			return days_count
		4:
			days_count = 30
			return days_count
		5:
			days_count = 31
			return days_count
		6:
			days_count = 30
			return days_count
		7:
			days_count = 31
			return days_count
		8:
			days_count = 31
			return days_count
		9:
			days_count = 30
			return days_count
		10:
			days_count = 31
			return days_count
		11:
			days_count = 30
			return days_count
		12:
			days_count = 31
			return days_count
		_: 
			print("Month not found.")
			return 0



func _get_current_weekday_label(weekday: int):
	var day = weekday
	match day:
		1:
			current_weekday_label = "Monday"
		2:
			current_weekday_label = "Tuesday"
		3:
			current_weekday_label = "Wednesday"
		4:
			current_weekday_label = "Thursday"
		5:
			current_weekday_label = "Friday"
		6:
			current_weekday_label = "Saturday"
		7:
			current_weekday_label = "Sunday"
		_: 
			print("Out of bounds.")

var day_cells = []

var next_month_date = 1
var next_month_weekday
var last_month_end_day


func _day_cells(month: int, weekday: int, date: int):
	number_of_days = _get_current_month(month)
	var all_cells = []
	day_cells = []
	var cell_index
	var next_month_first_day=1
	next_month_weekday=0
	day_cells.append(get_node("Week1").get_children())
	day_cells.append(get_node("Week2").get_children())
	day_cells.append(get_node("Week3").get_children())
	day_cells.append(get_node("Week4").get_children())
	day_cells.append(get_node("Week5").get_children())
	day_cells.append(get_node("Week6").get_children())
	
	var finding_cell
	var lookup_cell
	var last_month = _get_current_month(current_month-1)
	
		#print("ooga booga" + " " + str(date))
		#print(weekday)
	finding_cell = day_cells[date/7]
	finding_cell[weekday-1].label.text = str(date)
	finding_cell[weekday-1].calendar_cell.color = Color(0.56,0.56,0.56)
	finding_cell[weekday-1].calendar_cell.modulate.a = 1
	print("I TRIGGERED.")
	lookup_cell = finding_cell[weekday-1]
	for cells in day_cells:
		for child in cells:
			var cell = child
			all_cells.append(cell)
	
	cell_index = all_cells.find(lookup_cell)
	#print("Jajaja" + " " + str(cell_index))
	
	while(cell_index>0): 
		if date == 0:
			last_month_end_day = (cell_index-1)%7
		#print(last_month)
		var current_cell = all_cells[cell_index-1]
		print("nemojme" + str(cell_index))
		current_cell.label.text = str(last_month)
		print(current_cell.label.text)
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		cell_index-=1
		last_month-=1
	
	cell_index = all_cells.find(lookup_cell)
	date = on_open_date
		
	while(date<number_of_days):
		date+=1
		print("mojme" + str(cell_index))
		var current_cell = all_cells[cell_index+1]
		current_cell.label.text = str(date)
		print(current_cell.label.text)
		current_cell.calendar_cell.color = Color(0.56,0.56,0.56)
		current_cell.calendar_cell.modulate.a = 1
		cell_index+=1
		
	while(date>=number_of_days && cell_index<41):
		date+=1
		var current_cell = all_cells[cell_index+1]
		current_cell.label.text = str(next_month_first_day)
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		if next_month_first_day == 1:
			var index = all_cells.find(current_cell,0)
			next_month_weekday = (index+1)%7
			#print(index)
		cell_index+=1
		next_month_first_day+=1
	
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_last_month_button_pressed():
	_day_cells(on_open_month, last_month_end_day, on_open_date)
	current_month_label = get_label_text._get_current_month_label(current_month)
	if "January" in label_text.text:
		on_open_year -=1
	label_text.text = current_month_label + " " + str(on_open_year)
	if on_open_month == 1:
		on_open_month = 13
	pass # Replace with function body.


func _on_next_month_button_pressed():
	current_month+=1
		#print(current_month)
	#print(current_month)
	if "December" in current_month_label:
		on_open_year +=1
		current_month=1
	_day_cells(current_month,next_month_weekday,next_month_date)
	current_month_label = get_label_text._get_current_month_label(current_month)
	label_text.text = current_month_label + " " + str(on_open_year)
	if current_month == 12:
		current_month = 1
	print(number_of_days)
	pass # Replace with function body.
