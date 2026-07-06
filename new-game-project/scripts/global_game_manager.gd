extends Node

#global vairables

var money = 0
var ball_price = 100
var god_mode = false
var player_strength = 1
var player_value = 5

func _ready() -> void:
	if god_mode:
		ball_price = -10000
	
func _process(delta):
	pass
