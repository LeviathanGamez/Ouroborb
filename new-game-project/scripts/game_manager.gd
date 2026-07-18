extends Node

@onready var money_label = $"../Counter/Control/Money"
@onready var add_ball_price = $"../Buttons/Control/Add Ball Button/Add Ball/Price"
@onready var UI =  $"../UI" 
@onready var tiles = $"../Tiles"
@onready var skill_tree = $"../UI/SkillTree"
@onready var hamburger = $"../Hamburger/hamburger"
@onready var resume = $"../Settings/Resume"
@onready var settings = $"../Settings"
var money_text = preload("res://scenes/money.tscn")

var tile_scene = preload("res://scenes/tile.tscn")
var gold = preload("res://resources/tile_types/gold.tres")
var diamond = preload("res://resources/tile_types/diamond.tres")
var colors = [Color.html("#ff306c"), Color.html("#ffe74c"),Color.html("#48ff00"),
			Color.html("#179c43"), Color.html("#ffa200"),Color.html("#31d4e0"),
			Color.html("#1629f7"),Color.html("#8e1cc7"),Color.html("#f018f0"),
			Color.html("#006ec2"),Color.html("#c40c2e"),Color.html("#f2621f"),
			Color.html("#e29bfa"),Color.html("#d94c8e")]
			
var pickeable = colors.duplicate()
var loops = 1
var run_nodes = true
# Called when the node enters the scene tree for the first time.
# They're 100 x 36px
var paused = false
func _ready() -> void:
	spawn_blocks(loops)
	loops+=1
	#make skill tree visible
	skill_tree.visible = true
	UI.visible = false
	for i in range(GlobalGameManager.max_label_count):
		var money_a = money_text.instantiate()
		get_tree().current_scene.get_node("Money_texts").add_child(money_a)
		money_a.visible = false
		GlobalGameManager.label_pool.append(money_a)
	

func _input(event):
	if event.is_action_pressed("DEBUG"):
		print("Requested with DEBUG")
		GlobalGameManager.print_stats()
	elif event.is_action_pressed("UPGRADE"):
		GlobalGameManager.toggle_pause(UI)
	elif event.is_action_pressed("PAUSE"):
		if not settings.visible:
			hamburger._on_pressed()
		else:
			resume._on_pressed()
		paused = not paused
		
		 
func _process(_delta):
	set_money_prices()
	if get_tree().get_nodes_in_group("Colliders").size()==0 and run_nodes:
		run_nodes = false
		spawn_blocks(loops)
		loops+=1
	
func set_money_prices():
	money_label.text = str(GlobalGameManager.money)
	add_ball_price.text = "$"+ GlobalGameManager.numberphy(int(GlobalGameManager.ball_price))


	
func spawn_blocks(current_loop):
	var random_num = randi_range(0,100)
	if random_num < 30:
		for i in range(0,5):
			for j in range(0,5):
				var tile_a = tile_scene.instantiate()
				tile_a.position = Vector2(215+180*i,150+80*j)

				var sprite = tile_a.get_node("Sprite2D")
				type_check(tile_a,sprite)
				tiles.add_child(tile_a)
				tile_a.value = tile_a.value * current_loop
	
				
	elif random_num < 60:
		for i in range(0,8):
			for j in range(0,6):
				var tile_a = tile_scene.instantiate()
				tile_a.position = Vector2(222+100*i,150+36*j)
				
				var sprite = tile_a.get_node("Sprite2D")
				type_check(tile_a,sprite)
				tiles.add_child(tile_a)
				tile_a.value = tile_a.value * current_loop
		
				
	elif random_num <=77:
		for i in range(0,9):
			for j in range(0,13):
				if (i + j) % 2 == 1:
					continue
				var tile_a = tile_scene.instantiate()
				tile_a.position = Vector2(178+100*i,94+36*j)
				var sprite = tile_a.get_node("Sprite2D")
				type_check(tile_a,sprite)
				tiles.add_child(tile_a)
				tile_a.value = tile_a.value * current_loop
	elif random_num <= 94:
		for i in range(0,9):
			for j in range(0,13):
				if (i + j) % 2 == 0:
					continue
				var tile_a = tile_scene.instantiate()
				tile_a.position = Vector2(178+100*i,94+36*j)
				var sprite = tile_a.get_node("Sprite2D")
				type_check(tile_a,sprite)
				tiles.add_child(tile_a)
				tile_a.value = tile_a.value * current_loop
	elif random_num <= 99:
		for i in range(0,9):
			for j in range(0,13):
				var tile_a = tile_scene.instantiate()
				tile_a.position = Vector2(178+100*i,94+36*j)
				var sprite = tile_a.get_node("Sprite2D")
				type_check(tile_a,sprite)
				tiles.add_child(tile_a)
				tile_a.value = tile_a.value * current_loop
				
	
	run_nodes = true
				
func set_color(sprite):
	var selected_color = pickeable.pick_random()
	sprite.modulate = selected_color
	pickeable.erase(selected_color)
				
	if pickeable.size() == 0:
		pickeable = colors.duplicate()
	
func type_check(obj,sprite):
	if  randf() <= GlobalGameManager.global_diamond_tiles:
		obj.stats = diamond
	elif randf() <= GlobalGameManager.global_gold_tiles:
		obj.stats = gold
	else:
		set_color(sprite)
	
	
