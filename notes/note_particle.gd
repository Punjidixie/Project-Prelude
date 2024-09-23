extends PlayAreaObject

class_name NoteParticle

enum ParticleAnimation {LOOP, ONE_TIME}

@export var animation_player: AnimationPlayer
@export var y_offset: float # WORLD UNITS upwards

# x: play units
# angle: degrees
# direction: -1 or 1
func initialize(x: float, angle: float, direction: int):
	position.y = -y_offset * direction
	update_play_position()
	
	play_position.x = x
	update_world_position()
	
	if direction == 1:
		rotation = deg_to_rad(angle)
	elif direction == -1:
		rotation = deg_to_rad(180 - angle)
	
func play_animation(animation_type: ParticleAnimation):
	var animation_name_map = {
		ParticleAnimation.ONE_TIME: "end",
		ParticleAnimation.LOOP: "hold"
	}
	animation_player.play(animation_name_map[animation_type])
