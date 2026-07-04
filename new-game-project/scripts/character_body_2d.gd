extends CharacterBody2D


@onready var animation_player= $AudioStreamPlayer2D

 

func _ready():
	velocity = Vector2(1,1)

func _physics_process(delta: float) -> void:
	

	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		animation_player.play()
