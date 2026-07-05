extends Button
@onready var game = $"../.."

var ball = preload("res://scenes/Ball.tscn")


func _on_pressed() -> void:
	if GlobalGameManager.money >= GlobalGameManager.ball_price:
		GlobalGameManager.money -= GlobalGameManager.ball_price
		GlobalGameManager.ball_price += 100

		var ball_a = ball.instantiate() # Replace with function body.
		ball_a.get_node("CharacterBody2D").position = Vector2(500, 300)
	
		
		game.add_child(ball_a)
