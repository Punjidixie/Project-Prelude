extends NoteEvent

class_name EndEvent

@export var end_checkpoint: NoteCheckpoint
@export var end_speed: float

func _ready():
	start_time = end_checkpoint.target_time

func get_notebody_play_position(local_time: float):
	#if GlobalManager.is_auto_play:
	if true:
		return end_checkpoint.play_position
	
	var time_diff = local_time - start_time
	return end_checkpoint.play_position - Vector2(0, end_speed * time_diff)
