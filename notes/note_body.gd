extends PlayAreaObject

class_name NoteBody

@export var body: Control
@export var note: Note

func update_size():
	var world_size = PlayAreaUtils.get_delta_world_position(Vector2.ONE * note.note_size)
	body.size.x = world_size.x / body.scale.x
	
	body.position = - (body.size / 2) * body.scale
