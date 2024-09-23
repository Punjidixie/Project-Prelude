extends PlayAreaObject

class_name NoteBody

@export var hitbox: Hitbox
@export var note: Note
@export var animation_player: AnimationPlayer

func _ready():
	super._ready()
	hitbox.on_pressed.connect(on_body_pressed)

func reset():
	animation_player.play("RESET")
	hitbox.mouse_filter = Control.MOUSE_FILTER_STOP
	
func update_size():
	var world_size = PlayAreaUtils.get_delta_world_position(Vector2.ONE * note.note_size)
	hitbox.size.x = world_size.x / hitbox.scale.x
	
	hitbox.position = - (hitbox.size / 2) * hitbox.scale

func on_body_pressed():
	note.get_hit()
	animation_player.play("end")
	hitbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
# Called from the note when time updates
func update_appearance():
	pass
	
