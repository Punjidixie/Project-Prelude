extends Node

class_name Note

@export var start_time: float
@export var note_size: float
@export var note_events_container: Node
@export var note_body: NoteBody

var is_in_time: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func on_time_updated():
	update()

func update():
	# Calculates note body position
	if is_in_time:
		var time = GlobalManager.current_time
		var event = get_event_at_time(time)
		var play_position = event.get_notebody_play_position(time - start_time)
		note_body.set_play_position(play_position)
		#note_body.update_appearance()

func get_note_events() -> Array:
	var note_events = note_events_container.get_children()
	
	note_events.sort_custom(SortingFunctions.compare_note_events)
	return note_events

### UTILITY FUNCTIONS BELOW ###
func get_event_at_time(time: float):
	var local_time = time - start_time
	var note_events = get_note_events()
	for i in range(note_events.size() -1, -1, -1):
		if local_time > note_events[i].start_time:
			return note_events[i]
	
	return note_events[0]
