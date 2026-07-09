extends CharacterBody2D


@onready var audio_player= $AudioStreamPlayer2D
@onready var audio_player2= $AudioStreamPlayer2D2
@onready var sprite = $Sprite2D
@export var stats: level_stats

@onready var money_text_node = $Money_texts
var money_text = preload("res://scenes/money.tscn")

var speed 
var power
var value
var color
var crit
var sizes
var crit_power
var crit_value

var button_editor = preload("res://scripts/tweens.gd")
var tween = create_tween()

var particle_scene = preload("res://scenes/particles.tscn")
var particle

func _ready():
	add_to_group("balls")
	set_up_variables()
	
	#spawn particles
	particle = particle_scene.instantiate()
	add_child(particle)
	var particle_a = particle.get_node("CPUParticles2D")
	particle_a.restart()
	particle_a.emitting = true

func damage(collided):
	
	if randf() < crit:
		GlobalGameManager.add_count(crit_value)
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.html("EFBF04"))
		audio_player2.pitch_scale= randf_range(0.9,1.25)
		audio_player2.play()
		#money animation
		var money_a = money_text.instantiate()
		get_tree().current_scene.get_node("Money_texts").add_child(money_a)
		money_a.global_position = collided.global_position
		money_a.get_node("RichTextLabel").text = "+"+str(collided.crit_value)+"$"
	
	else:
		GlobalGameManager.add_count(value)
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.WHITE)
		audio_player.pitch_scale= randf_range(0.9,1.25)
		audio_player.play()
		collided.value -= power
		#money animation
		var money_a = money_text.instantiate()
		get_tree().current_scene.get_node("Money_texts").add_child(money_a)
		money_a.global_position = collided.global_position
		money_a.get_node("RichTextLabel").text = "+"+str(value)+"$"
	
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
			audio_player.pitch_scale= randf_range(0.9,1.25)
			audio_player.play()
	
		
		
func god_mode_check():
	if GlobalGameManager.god_mode:
		speed = 16
		power = 5
		
func set_up_variables():
	
	speed = stats.speed * GlobalGameManager.global_speed
	power = int(round(stats.power + GlobalGameManager.global_ball_power))
	crit = stats.crit + GlobalGameManager.global_ball_crit
	sizes = stats.size * GlobalGameManager.global_size
	value = int(round(stats.value + GlobalGameManager.global_tile_worth))
	crit_power = power*GlobalGameManager.ball_crit_mult*GlobalGameManager.global_ball_crit_power
	crit_value = int(round(value*GlobalGameManager.ball_crit_mult*GlobalGameManager.global_ball_crit_power))
	
	god_mode_check()
	scale = Vector2(sizes,sizes)
	color = stats.color
	modulate = color
	velocity = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()*speed
	sprite.texture = stats.texture
	
func spawn_particles(collision):
	particle = particle_scene.instantiate()
	add_child(particle)
	particle.global_position = collision.get_position()
	var particle_a = particle.get_node("CPUParticles2D")
	particle_a.restart()
	particle_a.emitting = true
	particle_a.rotation = collision.get_normal().angle() + PI / 2
	
							
