extends Node

class_name Note

enum NoteType {CLICK, HOLD, DRAG, FLICK}

@export var start_time: float
@export var note_size: float
@export var note_type: NoteType

@export var note_events_container: Node
@export var note_body: NoteBody
@export var note_effects: NoteEffects

@export var end_event: EndEvent

var is_in_time: bool = true

var hit_time: float = 0
var is_hit: bool = false
var hit_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_time_auto_updated.connect(on_time_updated)
	SignalManager.on_time_manual_updated.connect(on_time_updated)
	
	note_body.update_size()
	update_visibility()
	update()

func reset():
	var is_hit: bool = false
	on_time_updated()

func on_time_updated():
	update_visibility()
	update()

func get_hit():
	is_hit = true
	hit_time = GlobalManager.current_time
	note_effects.spawn_particles(note_body.play_position)

func update():
	# Calculates note body position
	if is_in_time:
		if not is_hit:
			var time = GlobalManager.current_time
			var event = get_event_at_time(time)
			var play_position = event.get_notebody_play_position(time - start_time)
			note_body.set_play_position(play_position)
		note_body.update_appearance()

func update_visibility():
	var end_offset = end_event.get_ending_lifetime()
	var time_lower_bound = start_time
	var time_upper_bound = start_time + end_event.start_time + end_offset
	var is_time_out_of_range = not GodotUtils.is_between(GlobalManager.current_time, time_lower_bound, time_upper_bound)
	if is_time_out_of_range and is_in_time: 
		is_in_time = false
		note_body.visible = false
	elif not is_time_out_of_range and not is_in_time:
		is_in_time = true
		note_body.visible = true

func get_note_events() -> Array:
	var note_events = note_events_container.get_children()
	
	note_events.sort_custom(SortingFunctions.compare_note_events)
	return note_events

func get_event_at_time(time: float):
	var local_time = time - start_time
	var note_events = get_note_events()
	for i in range(note_events.size() -1, -1, -1):
		if local_time > note_events[i].start_time:
			return note_events[i]
	
	return note_events[0]
