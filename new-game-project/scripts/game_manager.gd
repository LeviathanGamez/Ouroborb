extends Node

@onready var money_label = $"../Counter/Control/Label"
@onready var add_ball_price = $"../Buttons/Add Ball Button/Add Ball/Price"


var tile_scene = preload("res://scenes/tile.tscn")
var colors = [Color.html("#ff306c"), Color.html("#ffe74c"),Color.html("#48ff00"),
			Color.html("#179c43"), Color.html("#ffa200"),Color.html("#31d4e0"),
			Color.html("#1629f7"),Color.html("#8e1cc7"),Color.html("#f018f0"),
			Color.html("#006ec2"),Color.html("#c40c2e"),Color.html("#f2621f"),
			Color.html("#e29bfa"),Color.html("#d94c8e")]
			
var pickeable = colors.duplicate()
var loops = 1
# Called when the node enters the scene tree for the first time.
# They're 100 x 36px

func _ready() -> void:
	spawn_blocks(loops)
	loops+=1
	
		
func _process(delta):
	set_money_prices()
	if get_tree().get_nodes_in_group("Colliders").size()==0:
		spawn_blocks(loops)
		loops+=1
	
func set_money_prices():
	money_label.text = str(GlobalGameManager.money)
	add_ball_price.text = "$"+ str(GlobalGameManager.ball_price)
func spawn_blocks(current_loop):
	for i in range(0,5):
		for j in range(0,5):
			var tile_a = tile_scene.instantiate()
			tile_a.position = Vector2(200+180*i,150+80*j)
			add_child(tile_a)
			tile_a.value = tile_a.value * current_loop
			var sprite = tile_a.get_node("Sprite2D")
			var selected_color = pickeable.pick_random()
			sprite.modulate = selected_color
			pickeable.erase(selected_color)
			
			if pickeable.size() == 0:
				pickeable = colors.duplicate()
