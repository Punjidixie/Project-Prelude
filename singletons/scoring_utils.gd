extends Node

var perfect_window = 0.1
var good_window = 0.5

func get_note_result(delta_time: float) -> Note.NoteResult:
	if abs(delta_time) < perfect_window:
		return Note.NoteResult.PERFECT
	elif abs(delta_time) < good_window:
		return Note.NoteResult.GOOD
	else:
		return Note.NoteResult.BAD

func get_release_note_result(delta_time: float) -> Note.NoteResult:
	if abs(delta_time) < perfect_window * 2:
		return Note.NoteResult.PERFECT
	elif abs(delta_time) < good_window * 2:
		return Note.NoteResult.GOOD
	else:
		return Note.NoteResult.BAD
