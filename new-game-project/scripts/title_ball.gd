extends CharacterBody2D

var speed = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_a = randi_range(-speed,speed)
	
	var random_b = randi_range(-speed,speed)
	while Vector2(random_a,random_b)== Vector2.ZERO:
		random_a = randi_range(-speed,speed)
		random_b = randi_range(-speed,speed)
		
	velocity = Vector2(random_a,random_b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
