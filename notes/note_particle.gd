extends PlayAreaObject

class_name NoteParticle

@export var animation_player: AnimationPlayer
@export var y_offset: float # WORLD UNITS upwards

# x: play units
# angle: degrees
# direction: -1 or 1
func initialize(x: float, angle: float, direction: int):
	position.y = -y_offset * direction
	update_play_position()
	play_position.x = x
	
	if direction == 1:
		rotation = deg_to_rad(angle)
	elif direction == -1:
		rotation = deg_to_rad(180 - angle)
	update_world_position()
	animation_player.play("move")
