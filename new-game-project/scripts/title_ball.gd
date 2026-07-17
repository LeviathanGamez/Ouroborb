extends CharacterBody2D

var speed = 4

func _ready() -> void:
	var random_a = randi_range(-speed,speed)
	
	var random_b = randi_range(-speed,speed)
	while Vector2(random_a,random_b)== Vector2.ZERO:
		random_a = randi_range(-speed,speed)
		random_b = randi_range(-speed,speed)
		
	velocity = Vector2(random_a,random_b)



func _physics_process(_delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
