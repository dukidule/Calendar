extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var label = get_node("RichTextLabel")
@onready var calendar_cell = get_node("ColorRect")
@onready var text = get_node("TextEdit")

var saved_text = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = ""
	_get_text()
	pass # Replace with function body.

func _unhandled_key_input(event):
	saved_text = text.text
	print(saved_text)


func _get_text():
	if saved_text != "":
		text.text = saved_text
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
