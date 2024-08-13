extends Node


@export var play_area: Control
@export var notes_container: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_pause_button_pressed.connect(on_pause_button_pressed)
	GlobalManager.play_area = play_area
	add_note()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not GlobalManager.is_paused:
		auto_increment_time(delta)
	
func auto_increment_time(delta):
	var new_time = GlobalManager.current_time + delta
	GlobalManager.current_time = new_time
	SignalManager.on_time_auto_updated.emit()

func add_note():
	var hold_note: Note = ScenePreloader.base_hold_note.instantiate()
	notes_container.add_child(hold_note)

func on_pause_button_pressed():
	GlobalManager.is_paused = !GlobalManager.is_paused
	SignalManager.on_pause_toggled.emit()
	for note: Note in notes_container.get_children():
		note.reset()
