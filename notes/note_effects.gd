extends PlayAreaObject

class_name NoteEffects

@export var note: Note
@export var particle_gap: float # play units
@export var spread: float # -spread to spread

func spawn_particles(play_position: Vector2):
	set_play_position(play_position)
	GodotUtils.delete_all_children(self)
	var num_gaps = floor(note.note_size / particle_gap)
	var width = particle_gap * num_gaps
	var start_x = -width / 2
	
	var spread_gap = (spread * 2) / num_gaps
	
	for i in range(num_gaps + 1):
		var note_particle: NoteParticle = ScenePreloader.note_particle.instantiate()
		note_particle.initialize(start_x + i * particle_gap, -spread + i * spread_gap, 1)
		add_child(note_particle)
		
		var note_particle_2: NoteParticle = ScenePreloader.note_particle.instantiate()
		note_particle_2.initialize(start_x + i * particle_gap, -spread + i * spread_gap, -1)
		add_child(note_particle_2)
		
	
	
	
