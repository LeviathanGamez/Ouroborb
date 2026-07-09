extends Node

#global vairables


var god_mode = false
var infinite_money = false
var screenshake = false
var paused = false

var money = 0
var ball_price = 100

var player_strength = 1
var player_value = 5
var player_crit = 0.02
var ball_crit_mult = 2
var player_crit_mult = 2

var global_speed = 1 # +20% each _
var global_size = 1 # +20% each _
var global_money_mult = 1 # +20% each _
var global_ball_power = 0 # + 1 each _
var global_ball_crit = 1 # + 5% each _
var global_ball_crit_power = 1 # + 20% each _

var global_click_power = 0 # + 1 each
var global_click_crit = 1 # + 5% each
var global_click_crit_power = 1 # + 20% each

var global_tile_worth = 0 # +1 each
var global_rare_tiles =1 # +5% chance each



var label
var tween 
func _ready() -> void:
	if god_mode or infinite_money:
		money = 10000000000000
		
	

func add_count(value:int):
	if money >= 0:
		money += value * global_money_mult
	else:
		money += value
	if label != null:
		label.activate_tweens()

func toggle_pause(UI):
	paused = !paused
	UI.visible = paused
	UI.get_node("Panel").visible = paused
	await get_tree().process_frame
	get_tree().paused = paused
	#for child in UI.get_node("SkillTree").get_children()[0].get_children():
#		child.update_text()

func print_stats():
	print("=== GLOBAL STATS ===")
	print("Speed: x", global_speed,"%") # +20% each
	print("Size: x", global_size, "%") # +20% each
	print("Money Mult: x", global_money_mult, "%") # +20% each
	print("Ball Power: +", global_ball_power) # + 1 each
	print("Ball Crit: x", global_ball_crit, "%") # + 5% each
	print("Ball Crit Power: x", global_ball_crit_power, "%") # + 20% each
	print("Click Power: +", global_click_power) # +1 each
	print("Click Crit: x", global_click_crit, "%") # + 5% each
	print("Click Crit Power: x", global_click_crit_power,"%") # +20% each
	print("Tile Worth: +", global_tile_worth) # +1 each
	print("Rare Tiles: x", global_rare_tiles, "%") # +5% chance each
	
