extends Control

var colors = [Color.html("#ff306c"), Color.html("#ffe74c"),Color.html("#48ff00"),
			Color.html("#179c43"), Color.html("#ffa200"),Color.html("#31d4e0"),
			Color.html("#1629f7"),Color.html("#8e1cc7"),Color.html("#f018f0"),
			Color.html("#006ec2"),Color.html("#c40c2e"),Color.html("#f2621f"),
			Color.html("#e29bfa"),Color.html("#d94c8e")]
var pickeable = colors.duplicate()
var title_ball = preload("res://scenes/title_ball.tscn")
var balls = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(0.67).timeout
	var ball_a = title_ball.instantiate()
	ball_a.global_position = Vector2(randi_range(40,1000),randf_range(60,600))
	set_color(ball_a.get_node("Sprite2D"))
	add_child(ball_a)
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


func _on_options_button_button_up() -> void:
	pass # Replace with function body.
