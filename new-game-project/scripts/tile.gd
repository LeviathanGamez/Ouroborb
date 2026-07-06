extends Node2D

@export var value = 5

@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Colliders")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(value)
	if value <= 0:
		queue_free()



func _on_button_pressed() -> void:
	value -= GlobalGameManager.player_strength
	GlobalGameManager.add_count(GlobalGameManager.player_value)
