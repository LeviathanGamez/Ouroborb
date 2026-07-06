extends CharacterBody2D


@onready var animation_player= $AudioStreamPlayer2D
@onready var sprite = $Sprite2D
@export var stats: level_stats
var speed 
var power
var value
var color
func _ready():
	
	set_up_variables()

func damage(collided):
	collided.value -= stats.power
	GlobalGameManager.money += value
	
	
func _physics_process(delta: float) -> void:

	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		
		var collided = collision.get_collider()
		var collided_parent = collided.get_parent()
		
		if collided_parent.is_in_group("Colliders"):
			damage(collided_parent)
			animation_player.pitch_scale= randf_range(0.9,1.25)
			animation_player.play()
		else:
			animation_player.pitch_scale= randf_range(0.9,1.25)
			animation_player.play()
		
func god_mode_check():
	if GlobalGameManager.god_mode:
		speed = 16
		power = 5
func set_up_variables():
	speed = stats.speed
	power = stats.power
	god_mode_check()
	scale = Vector2(stats.size,stats.size)
	value = stats.value
	color = stats.color
	modulate = color
	add_to_group("balls")
	velocity = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()*speed
	sprite.texture = stats.texture
