extends Node

class_name NoteEvent

@export var start_time: float

var note: Note

# Called in Note. Calculate note position based on local_time. Override in inherited classes.
func get_notebody_play_position(local_time: float):
	pass
