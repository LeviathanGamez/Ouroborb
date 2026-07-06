extends Node

#global vairables


var money = 0
var ball_price = 100
var god_mode = true
var player_strength = 1
var player_value = 5

var label
var tween 
func _ready() -> void:

	if god_mode:
		ball_price = -10000
	
func _process(delta):
	pass
func add_count(value:int):
	money += value
	if label != null:
		label.activate_tweens()
	
