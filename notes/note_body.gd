extends PlayAreaObject

class_name NoteBody

@export var body: Hitbox
@export var note: Note
@export var animation_player: AnimationPlayer

func _ready():
	super._ready()
	body.on_pressed.connect(on_body_pressed)

func reset():
	animation_player.play("RESET")
	body.mouse_filter = Control.MOUSE_FILTER_STOP
	
func update_size():
	var world_size = PlayAreaUtils.get_delta_world_position(Vector2.ONE * note.note_size)
	body.size.x = world_size.x / body.scale.x
	
	body.position = - (body.size / 2) * body.scale

func on_body_pressed():
	note.get_hit()
	animation_player.play("note_animation")
	body.mouse_filter = Control.MOUSE_FILTER_IGNORE
	

func update_appearance():
	pass
	
