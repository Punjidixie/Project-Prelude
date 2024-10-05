extends NoteBody

class_name HoldNoteBody

@export var hold_body: Control
var ended = false

func _ready():
	super._ready()
	
	hitbox.on_released.connect(on_body_released)
	get_tree().get_root().size_changed.connect(update_height)

func reset():
	super.reset()
	ended = false

func _process(delta):
	var hold_note := note as HoldNote
	
	# If not ended and timed out
	if not ended and GlobalManager.current_time > (hold_note.end_event.start_time + hold_note.hold_time):
		match hold_note.hold_status:
			HoldNote.HoldStatus.HELD:
				on_body_released()
			HoldNote.HoldStatus.RELEASED:
				ended = true
				animation_player.play("imperfect_ending")
	
func on_body_pressed():
	var hold_note := note as HoldNote
	if hold_note.hold_status == HoldNote.HoldStatus.INITIAL:
		hold_note.start_hold()
		animation_player.play("hold") # Colors

func on_body_released():
	var hold_note := note as HoldNote
	if hold_note.hold_status == HoldNote.HoldStatus.HELD:
		hold_note.end_hold()
		hitbox.mouse_filter = Control.MOUSE_FILTER_IGNORE

### TO BE CALLED BACK FROM HOLDNOTE ###
func imperfect_release():
	animation_player.play("imperfect_release") # Colors dimming

func perfect_release():
	ended = true
	animation_player.play("perfect_ending") # Colors fading out, ending beautifully

func update_appearance():
	super.update_appearance()
	update_height()

func update_height():
	var hold_note := note as HoldNote
	var remaining_hold_time = hold_note.hold_time
	
	# Consume the hold bar if held or already released!!
	if hold_note.hold_status == HoldNote.HoldStatus.HELD or hold_note.hold_status == HoldNote.HoldStatus.RELEASED:
		var relative_time = GlobalManager.current_time - hold_note.start_time
		var time_since_end = relative_time - hold_note.end_event.start_time
		remaining_hold_time = hold_note.hold_time - time_since_end
	
	remaining_hold_time = clamp(remaining_hold_time, 0, hold_note.hold_time)
	
	var play_height = hold_note.end_event.end_speed * remaining_hold_time
	var world_height = - PlayAreaUtils.get_delta_world_position(Vector2(0, play_height))
	
	hold_body.size.y = world_height.y / hitbox.scale.y
	hold_body.position.y = (hitbox.size.y / 2) - hold_body.size.y # coords seem to be in local scale
	# x position is anchored to the body as 0.

	
