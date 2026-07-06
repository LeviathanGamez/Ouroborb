extends Button
@onready var game = $"../.."

var ball = preload("res://scenes/Ball.tscn")

var button_editor = preload("res://scripts/Button_editor.gd")
var tween = create_tween()

func _on_pressed() -> void:
	if GlobalGameManager.money >= GlobalGameManager.ball_price:
		GlobalGameManager.money -= GlobalGameManager.ball_price
		GlobalGameManager.ball_price += 100

		var ball_a = ball.instantiate() # Replace with function body.
		ball_a.get_node("CharacterBody2D").position = Vector2(550, 350)
	
		
		game.add_child(ball_a)
		




func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)
