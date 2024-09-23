extends Control

class_name Hitbox
signal on_pressed
signal on_released

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed(): on_pressed.emit()
			elif event.is_released(): on_released.emit()



