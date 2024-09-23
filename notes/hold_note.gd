extends Note

class_name HoldNote

enum HoldStatus {INITIAL, HELD, RELEASED}
@export var hold_time: float # max hold time

var hold_status: HoldStatus = HoldStatus.INITIAL

func reset():
	hold_status = HoldStatus.INITIAL
	super.reset()
	
func update():
	# Calculates note body position
	if is_in_time:
		update_position()
		note_body.update_appearance()

func start_hold():
	hold_status = HoldStatus.HELD
	note_result = ScoringUtils.get_release_note_result(GlobalManager.current_time - start_time)
	note_effects.play_looping_effects(note_result)

func end_hold():
	hold_status = HoldStatus.RELEASED
	get_hit()
	
func get_hit():
	var hold_note_body := note_body as HoldNoteBody
	is_hit = true
	hit_time = GlobalManager.current_time
	
	var new_note_result = ScoringUtils.get_release_note_result(hit_time - (start_time + hold_time))
	
	note_result = min(note_result, new_note_result)
	
	if note_result == NoteResult.PERFECT: hold_note_body.perfect_release()
	else: hold_note_body.imperfect_release()
	
	note_effects.play_end_effects(note_result)
	
	if note_result == NoteResult.PERFECT:
		note_body.set_play_position(end_event.end_checkpoint.play_position)


	

