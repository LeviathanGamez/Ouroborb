extends Node

#global vairables

var max_label_count = 2000
var label_pool = []
var label_pool_index = 0


var god_mode = false
var infinite_money = false
var screenshake = false
var paused = false

var money = 0
var ball_price = 50
var ball_price_increase = 50
var ball_price_increase_original = 50

var amount = 8
var angle = TAU/amount
var ball_count = 0

var player_strength = 1
var player_value = 5
var player_crit = 0.05
var ball_crit_mult = 2
var player_crit_mult = 2

var global_speed = 1 # +20% each _
var global_size = 1 # +20% each _
var global_money_mult = 1 # +20% each _
var global_ball_power = 0 # + 1 each _
var global_ball_crit = 0 # + 5% each _
var global_ball_crit_power = 1 # + 20% each _

var global_ball_mult = 1 # +100% each
var global_click_mult = 1 # +100% each
var global_ball_worth = 1 # +100% each
var global_click_worth = 1 # +100% each

var global_click_power = 0 # + 1 each
var global_click_crit = 0 # + 5% each
var global_click_crit_power = 1 # + 20% each

var global_steel_ball = 1  # + 20% each
var global_pristine_ball = 1  # + 20% each


var global_tile_worth = 0 # +1 each
var global_gold_tiles = 0 # +5% chance each
var global_diamond_tiles = 0 # +5% chance each
var global_gold_mult = 1 # +5% chance each
var global_diamond_mult = 1 # +5% chance each


var label
var tween 

func _ready() -> void:
	if god_mode or infinite_money:
		money = 10000000000000
	god_mode_check()
	

		
	

func add_count(value:int):
	money += value 
	money = int(round(money))
	if label != null:
		label.activate_tweens()

func toggle_pause(UI):
	paused = !paused
	
	for child in UI.get_children():
		child.visible = paused
	UI.visible = paused
	await get_tree().process_frame
	#get_tree().paused = paused
	#for child in UI.get_node("SkillTree").get_children()[0].get_children():
#		child.update_text()
func god_mode_check():
	if god_mode:
		global_speed = 16 # +20% each _
		global_size = 4 # +20% each _
		global_ball_power = 30 # + 1 eac
		
func print_stats():
	print("=== GLOBAL STATS ===")
	print("Speed: x", global_speed,"%") # +20% each
	print("Size: x", global_size, "%") # +20% each
	print("Money Mult: x", global_money_mult, "%") # +20% each
	print("Ball Power: +", global_ball_power) # + 1 each
	print("Ball Crit: +", global_ball_crit, "%") # + 5% each
	print("Ball Crit Power: x", global_ball_crit_power, "%") # + 20% each
	print("Click Power: +", global_click_power) # +1 each
	print("Click Crit: +", global_click_crit, "%") # + 5% each
	print("Click Crit Power: x", global_click_crit_power,"%") # +20% each
	print("Tile Worth: +", global_tile_worth) # +1 each
	print("Click Worth x", global_click_worth, "%")
	print("Ball Worth x", global_ball_worth, "%")
	print("Ball Mult: x", global_ball_mult, "%")
	print("Click mult x", global_click_mult, "%")
	print("Gold Tiles: x", global_gold_tiles, "%") # +5% chance each
	print("Diamond Tiles: x", global_diamond_tiles, "%") # +5% chance each
	print("Ball Mult: x", global_ball_mult, "%")
	print("Ball Mult: x", global_ball_mult, "%")
	print("Steel: x", global_steel_ball, "%") # +20% each
	print("Tough: x", global_steel_ball, "%") # +20% each
	
func price_increase() -> void:
	ball_price += ball_price_increase
	
	ball_count += 1
	if ball_count % 10 == 0:
		ball_price_increase += ball_price_increase_original

func numberphy(num: int) -> String:
	var s := str(num)
	for i in range(s.length() - 3, 0, -3):
		s = s.insert(i, ",")
	return s
