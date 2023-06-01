extends Node

@onready var on_open_month = get_parent().on_open_month
@onready var on_open_weekday = get_parent().on_open_weekday
@onready var on_open_date = get_parent().on_open_date
@onready var on_open_year = get_parent().on_open_year
@onready var number_of_days = get_parent()._get_current_month(on_open_month)
#labels
var current_month_label = ""
var current_weekday_label = ""
#used variables

# Called when the node enters the scene tree for the first time.
func _ready():
	print(on_open_date)
	_day_cells()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	date = get_parent().on_open_date
	
	var finding_cell
	var lookup_cell
	var next_month_date=1
	var last_month_date = get_parent().last_month_date
	
	
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
	
	while(date<number_of_days):
		date+=1
		var current_cell = all_cells[cell_index+1]
		current_cell.label.text = str(date)
		cell_index+=1
		
	while(date>=number_of_days && cell_index<41):
		date+=1
		var current_cell = all_cells[cell_index+1]
		current_cell.label.text = str(next_month_date)
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		cell_index+=1
		next_month_date+=1
	
	cell_index = all_cells.find(lookup_cell)
	date = on_open_date
	
	while(date>1 && date<=number_of_days):
		date-=1
		var current_cell = all_cells[cell_index-1]
		current_cell.label.text = str(date)
		cell_index-=1
		
	while(date<=1 && cell_index>0): 
		date-=1
		print(date)
		print(cell_index)
		var current_cell = all_cells[cell_index-1]
		current_cell.label.text = str(last_month_date)
		current_cell.calendar_cell.color = Color(0.14,0.13,0.13)
		current_cell.calendar_cell.modulate.a = 0.5
		cell_index-=1
		last_month_date-=1


func _on_next_month_pressed():
	get_parent().on_open_month-=1
	pass # Replace with function body.


func _on_previous_month_pressed():
	pass # Replace with function body.
