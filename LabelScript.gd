extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _get_current_month_label(month: int) -> String:
	var current_month_label = ""
	match month:
		1:
			current_month_label = "January"
			return current_month_label
		2:
			current_month_label = "February"
			return current_month_label
		3:
			current_month_label = "March"
			return current_month_label
		4:
			current_month_label = "April"
			return current_month_label
		5:
			current_month_label = "May"
			return current_month_label
		6:
			current_month_label = "June"
			return current_month_label
		7:
			current_month_label = "July"
			return current_month_label
		8:
			current_month_label = "August"
			return current_month_label
		9:
			current_month_label = "September"
			return current_month_label
		10:
			current_month_label = "October"
			return current_month_label
		11:
			current_month_label = "November"
			return current_month_label
		12:
			current_month_label = "December"
			return current_month_label
		_: 
			print("Month not found.")
			return current_month_label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
