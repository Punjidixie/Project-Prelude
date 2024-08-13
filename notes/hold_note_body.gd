extends NoteBody

class_name HoldNoteBody

@export var hold_body: Control

func _ready():
	super._ready()
	get_tree().get_root().size_changed.connect(update_height)


func update_height():
	var hold_note := note as HoldNote
	var remaining_hold_time = hold_note.hold_time
	
	# Finger is holding!!
	if hold_note.is_held:
		var relative_time = GlobalManager.current_time - hold_note.start_time
		var time_since_end = relative_time - hold_note.end_event.start_time
		remaining_hold_time = clampf(hold_note.hold_time - time_since_end, 0, hold_note.hold_time)
	
	# Finger lifted
	elif hold_note.is_hit and not hold_note.is_held:
		var absolute_end_time = hold_note.start_time + hold_note.end_event.start_time
		var total_time_held = hold_note.lift_time - absolute_end_time
		remaining_hold_time = hold_note.hold_time - total_time_held
	
	var play_height = hold_note.end_event.end_speed * remaining_hold_time
	var world_height = - PlayAreaUtils.get_delta_world_position(Vector2(0, play_height))
	
	hold_body.size.y = world_height.y / body.scale.y
	hold_body.position.y = (body.size.y / 2) - hold_body.size.y # coords seem to be in local scale
	# x position is anchored to the body as 0.

func update_appearance():
	super.update_appearance()
	update_height()
	
