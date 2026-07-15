extends CharacterBody2D


@onready var audio_player= $AudioStreamPlayer2D
@onready var audio_player2= $AudioStreamPlayer2D2
@onready var sprite = $Sprite2D
@export var stats: level_stats

var money_text = preload("res://scenes/money.tscn")

var speed 
var power
var value
var color
var crit
var sizes
var crit_power
var crit_value

#object pooling

var particle_scene = preload("res://scenes/particles.tscn")
var particle

var particle_scene2 = preload("res://scenes/particles_collision.tscn")
var particle2

func _ready():
	add_to_group("balls")
	velocity = Vector2(randf_range(-1,1),randf_range(-1,1))
	set_up_variables()
	
	#spawn particles
	particle = particle_scene.instantiate()
	add_child(particle)
	var particle_a = particle.get_node("CPUParticles2D")
	particle_a.restart()
	particle_a.emitting = true
	if audio_player and audio_player.stream:
		audio_player.stream = audio_player.stream.duplicate()
	if audio_player2 and audio_player2.stream:
		audio_player2.stream = audio_player2.stream.duplicate()


func damage(collided):
	var temp_crit_value = crit_value * collided.stats.tile_type_mult
	var temp_value = value * collided.stats.tile_type_mult
	
	if collided.stats.type == 1:
		temp_value = int(round(temp_value * GlobalGameManager.global_gold_mult))
		temp_crit_value = int(round(temp_crit_value * GlobalGameManager.global_gold_mult))
	elif collided.stats.type == 2:
		temp_value = int(round(temp_value * GlobalGameManager.global_diamond_mult))
		temp_crit_value = int(round(temp_crit_value * GlobalGameManager.global_diamond_mult))
	
	if randf() < crit:
		GlobalGameManager.add_count(temp_crit_value)
		collided.value -= crit_power
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.html("EFBF04"))
		play_sound(audio_player2)
		#money animation
		spawn_text_pooled(collided,temp_crit_value)
	
	else:
		GlobalGameManager.add_count(temp_value)
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.WHITE)
		play_sound(audio_player)
		collided.value -= power
		#money animation
		spawn_text_pooled(collided,temp_value)
	collided.get_node("HitFlashAnimationPlayer").play("hit_flash")
		




	
func _physics_process(_delta: float) -> void:

	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		var collided = collision.get_collider()
		var collided_parent = collided.get_parent()
		
		if collided_parent.is_in_group("Colliders"):
			damage(collided_parent)
		else:
			play_sound(audio_player)
			
		#spawn_particles(collision)
	
		
		
		
func set_up_variables():
	
	speed = stats.speed * GlobalGameManager.global_speed
	power = int(round(stats.power + GlobalGameManager.global_ball_power))
	crit = stats.crit + GlobalGameManager.global_ball_crit
	sizes = stats.size * GlobalGameManager.global_size
	value = stats.value + GlobalGameManager.global_tile_worth
	crit_power = power*GlobalGameManager.ball_crit_mult*GlobalGameManager.global_ball_crit_power
	crit_value = value*GlobalGameManager.ball_crit_mult*GlobalGameManager.global_ball_crit_power
	power = power * GlobalGameManager.global_ball_mult * GlobalGameManager.global_steel_ball
	crit_power = crit_power * GlobalGameManager.global_ball_mult * GlobalGameManager.global_steel_ball
	value = int(round(value * GlobalGameManager.global_ball_worth * GlobalGameManager.global_money_mult * GlobalGameManager.global_pristine_ball))
	crit_value = int(round(crit_value * GlobalGameManager.global_ball_worth * GlobalGameManager.global_money_mult * GlobalGameManager.global_pristine_ball))

	scale = Vector2(sizes,sizes)
	color = stats.color
	modulate = color
	velocity = velocity.normalized()*speed
	sprite.texture = stats.texture
	
func spawn_text_pooled(collided,value):
	var money_text = GlobalGameManager.label_pool[GlobalGameManager.label_pool_index]
	money_text.visible = true
	GlobalGameManager.label_pool_index = wrap(GlobalGameManager.label_pool_index + 1,0,GlobalGameManager.max_label_count)
	money_text.global_position = collided.global_position
	money_text.get_node("RichTextLabel").text = "+"+ GlobalGameManager.numberphy(int(round(value)))+"$"
	money_text.play_animation()
	

	
func spawn_particles(collision):
	particle2 = particle_scene2.instantiate()
	add_child(particle2)
	particle2.global_position = collision.get_position()
	var particle_a = particle2.get_node("CPUParticles2D")
	particle_a.restart()
	particle_a.emitting = true
	particle_a.one_shot = true
	particle_a.rotation = collision.get_normal().angle() 
	
func play_sound(audio):
	if audio.playing and audio.get_playback_position() <= 0.05:
		return

	if audio.playing:
		audio.stop()

	audio.pitch_scale = randf_range(0.9, 1.25)
	audio.play()	
								
