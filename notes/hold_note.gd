extends Note

class_name HoldNote

@export var hold_time: float # max hold time

var lift_time: float
var is_held: float = false

# DIFF: note body height needs to be calculated too
func _ready():
	super._ready()

func update():
	if is_in_time:
		var time = GlobalManager.current_time
		var event = get_event_at_time(time)
		var play_position = event.get_notebody_play_position(time - start_time)
		note_body.set_play_position(play_position)
		note_body.update_appearance()
	

