extends CharacterBody2D


@onready var audio_player= $AudioStreamPlayer2D
@onready var audio_player2= $AudioStreamPlayer2D2
@onready var sprite = $Sprite2D
@export var stats: level_stats

var speed 
var power
var value
var color
var crit
var button_editor = preload("res://scripts/tweens.gd")
var tween = create_tween()

func _ready():
	
	set_up_variables()

func damage(collided):
	
	if randf() < crit:
		GlobalGameManager.add_count(value*GlobalGameManager.ball_crit_mult)
		collided.value -= stats.power*GlobalGameManager.ball_crit_mult
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.html("EFBF04"))
		audio_player2.pitch_scale= randf_range(0.9,1.25)
		audio_player2.play()
		#hitflash
	else:
		collided.value -= stats.power
		GlobalGameManager.add_count(value)
		collided.get_node("Sprite2D").material.set_shader_parameter("Tint", Color.WHITE)
		audio_player.pitch_scale= randf_range(0.9,1.25)
		audio_player.play()
	collided.get_node("HitFlashAnimationPlayer").play("hit_flash")
		
	
	
	
func _physics_process(delta: float) -> void:

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
	particle_follow()
		
func god_mode_check():
	if GlobalGameManager.god_mode:
		speed = 16
		power = 5
func set_up_variables():
	speed = stats.speed
	power = stats.power
	crit = stats.crit
	god_mode_check()
	scale = Vector2(stats.size,stats.size)
	value = stats.value
	color = stats.color
	modulate = color
	add_to_group("balls")
	velocity = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()*speed
	sprite.texture = stats.texture
func particle_follow():
	for child in get_children():
		if child is CPUParticles2D:
			child.global_position = global_position
