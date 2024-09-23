extends EndEvent

class_name HoldEndEvent

func get_notebody_play_position(local_time: float):
	var hold_note := note as HoldNote
	
	if hold_note.hold_status == HoldNote.HoldStatus.HELD or hold_note.hold_status == HoldNote.HoldStatus.RELEASED:
		return end_checkpoint.play_position
	
	# Else if never held-> the note can go down
	var time_diff = local_time - start_time # time since the end started
	
	return end_checkpoint.play_position - Vector2(0, end_speed * time_diff)
	
func get_ending_lifetime():
	var hold_note := note as HoldNote
	return super.get_ending_lifetime() + hold_note.hold_time
