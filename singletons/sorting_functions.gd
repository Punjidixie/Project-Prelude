extends Node

func compare_note_events(a: NoteEvent, b: NoteEvent):
	return a.start_time < b.start_time
