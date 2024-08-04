extends Node


@export var play_area: Control
@export var notes_container: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalManager.play_area = play_area
	add_note()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_note():
	var note: Note = ScenePreloader.base_note.instantiate()
	notes_container.add_child(note)
