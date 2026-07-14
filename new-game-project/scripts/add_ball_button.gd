extends Button
@onready var game = $"../.."
@onready var balls = $"../../../Balls"

var ball = preload("res://scenes/ball.tscn")
@onready var camera = $"../../../Camera2D"
var button_editor = preload("res://scripts/tweens.gd")
var particle_click = preload("res://scenes/particles_click.tscn")


var tween 

func _on_pressed() -> void:
	if GlobalGameManager.money >= GlobalGameManager.ball_price:
		GlobalGameManager.add_count(-GlobalGameManager.ball_price)
		GlobalGameManager.price_increase()
		var ball_a = ball.instantiate() 
		ball_a.get_node("CharacterBody2D").position = Vector2(550, 350)
	
		
		balls.add_child(ball_a)
		
		camera.zoom_in(self)
		for i in range(0,GlobalGameManager.amount):
			var particle_a = particle_click.instantiate()
			particle_a.rotation  =  (i * GlobalGameManager.angle)
			particle_a.get_node("CPUParticles2D").emitting = true
			particle_a.global_position = get_global_mouse_position()
			get_tree().current_scene.get_node("Particles").add_child(particle_a)
		



func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)
