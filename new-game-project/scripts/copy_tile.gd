extends Node2D

var tween 
var button_editor = preload("res://scripts/tweens.gd")


func _ready() -> void:
	tween =  create_tween().set_parallel()
	scale = Vector2(1.1,1.1)
	modulate.a = 0.9
	button_editor.reset_tween(self)
	tween.tween_property(self, "scale", Vector2(1.3,1.3), 0.09)
	tween.tween_property(self, "modulate:a", 0.0, 0.09)

	tween.chain().tween_callback(queue_free)
