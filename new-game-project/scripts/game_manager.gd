extends Node

var tile_scene = preload("res://scenes/tile.tscn")
var colors = [Color.html("#ff306c"), Color.html("#ffe74c"),Color.html("#48ff00"),
			Color.html("#00cf2d"), Color.html("#ffa200"),Color.html("#31d4e0"),
			Color.html("#1629f7"),Color.html("#8e1cc7"),Color.html("#f018f0")]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tile_a = tile_scene.instantiate()
	tile_a.position = Vector2(600,300)
	add_child(tile_a)
	
	var sprite = tile_a.get_node("Sprite2D")
	sprite.modulate = colors.pick_random()
	
