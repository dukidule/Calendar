extends Node

# Called when the node enters the scene tree for the first time.

@onready var parent = get_parent()
func _ready():
	get_tree().get_root().set_transparent_background(true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		get_tree().get_root().set_transparent_background(false)
		parent.modulate.a = 1
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		get_tree().get_root().set_transparent_background(true)
		parent.modulate.a = 0.3
