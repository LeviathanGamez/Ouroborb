extends CharacterBody2D


@onready var animation_player= $AudioStreamPlayer2D

 

func _ready():
	velocity = Vector2(1,1)

func damage(collided):
	collided.value -= 1
	GlobalGameManager.money += 5
	
	
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
