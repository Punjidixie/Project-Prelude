extends Control

class_name Hitbox
signal on_pressed

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			on_pressed.emit()

