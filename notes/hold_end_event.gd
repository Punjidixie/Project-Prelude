extends EndEvent

class_name HoldEndEvent

func get_notebody_play_position(local_time: float):
	var hold_note := note as HoldNote
	
	if hold_note.is_held: return end_checkpoint.play_position
	
	# Else if not held
	var time_diff = local_time - start_time # time since the end started
	
	if hold_note.is_hit:
		var absolute_end_time = hold_note.start_time + hold_note.end_event.start_time
		var time_held = clamp(hold_note.lift_time - absolute_end_time, 0, hold_note.hold_time)
		time_diff -= time_held
	
	return end_checkpoint.play_position - Vector2(0, end_speed * time_diff)
	
func get_ending_lifetime():
	var hold_note := note as HoldNote
	return super.get_ending_lifetime() + hold_note.hold_time
