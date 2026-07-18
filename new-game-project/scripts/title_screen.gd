extends Control

@onready var balls_node = $Balls
@onready var settings = $Settings
@onready var options = $"Control2/Options Button"
@onready var resume = $Settings/Resume
var paused = false
var colors = [Color.html("#ff306c"), Color.html("#ffe74c"),Color.html("#48ff00"),
			Color.html("#179c43"), Color.html("#ffa200"),Color.html("#31d4e0"),
			Color.html("#1629f7"),Color.html("#8e1cc7"),Color.html("#f018f0"),
			Color.html("#006ec2"),Color.html("#c40c2e"),Color.html("#f2621f"),
			Color.html("#e29bfa"),Color.html("#d94c8e")]
var pickeable = colors.duplicate()
var title_ball = preload("res://scenes/title_ball.tscn")
var balls = []


func _input(event):
	if event.is_action_pressed("PAUSE"):
		if not settings.visible:
			options._on_pressed()
		else:
			resume._on_pressed()
		paused = not paused

func _process(_delta: float) -> void:
	await get_tree().create_timer(0.67).timeout
	var ball_a = title_ball.instantiate()
	ball_a.global_position = Vector2(randi_range(40,1000),randf_range(60,600))
	set_color(ball_a.get_node("Sprite2D"))
	balls_node.add_child(ball_a)
	balls.append(ball_a)
	if balls.size() >= 250:
		balls[0].queue_free()
		balls.remove_at(0)
		
func set_color(sprite):
	var selected_color = pickeable.pick_random()
	sprite.modulate = selected_color
	pickeable.erase(selected_color)
				
	if pickeable.size() == 0:
		pickeable = colors.duplicate()
