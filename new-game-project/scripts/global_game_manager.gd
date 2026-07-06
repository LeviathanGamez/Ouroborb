extends Node

#global vairables


var god_mode = false
var screenshake = false

var money = 0
var ball_price = -1000

var player_strength = 1
var player_value = 5
var player_crit = 0.02
var ball_crit_mult = 2
var player_crit_mult = 2

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
	
