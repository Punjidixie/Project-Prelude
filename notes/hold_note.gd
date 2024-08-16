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
		update_position()
		note_body.update_appearance()

func reset():
	is_held = false
	is_hit = false # super
	note_body.reset() # super
	on_time_updated()
	
	
func get_hit():
	super.get_hit()
	is_held = true

func get_released():
	lift_time = GlobalManager.current_time
	is_held = false
	

