extends Node2D

class_name NoteEffects

@export var note: Note
@export var particle_gap: float # play units
@export var spread: float # -spread to spread

func spawn_particles():
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

func play_looping_effects(note_result: Note.NoteResult):
	play_effects(NoteParticle.ParticleAnimation.LOOP, note_result)
	
func play_end_effects(note_result: Note.NoteResult):
	play_effects(NoteParticle.ParticleAnimation.ONE_TIME, note_result)

func play_effects(
	animation_type: NoteParticle.ParticleAnimation = NoteParticle.ParticleAnimation.ONE_TIME,
	note_result: Note.NoteResult = Note.NoteResult.PERFECT
	):
	spawn_particles()
	for particle: NoteParticle in get_children():
		particle.play_animation(animation_type)
	
	
	
		
	
	
	
