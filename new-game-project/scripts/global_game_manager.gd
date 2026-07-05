extends Node

#global vairables

var money = 0
var ball_price = 100
var god_mode = false

func _ready() -> void:
	if god_mode:
		ball_price = -1000
	
func _process(delta):
	pass
