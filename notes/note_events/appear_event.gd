extends NoteEvent

class_name AppearEvent

@export var start_checkpoint : NoteCheckpoint

func _ready():
	start_time = start_checkpoint.target_time

func get_notebody_play_position(local_time: float):
	return start_checkpoint.play_position
