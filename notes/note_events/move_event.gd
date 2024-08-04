extends NoteEvent

class_name MoveEvent

@export var path : Curve2D
@export var start_checkpoint : NoteCheckpoint
@export var destination_checkpoint : NoteCheckpoint

# get the current note's play position from local time
func get_notebody_play_position(local_time: float):
	var current_path_time = local_time - start_time
	
	var total_path_time: float
	if is_instance_valid(destination_checkpoint): 
		total_path_time = destination_checkpoint.target_time - start_time
	else:
		total_path_time = 0
	
	var progress_ratio = current_path_time / total_path_time
	return path.sample_baked(path.get_baked_length() * progress_ratio)
