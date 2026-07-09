extends Node2D

var tween =  create_tween().set_parallel()
var button_editor = preload("res://scripts/tweens.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(1.1,1.1)
	modulate.a = 0.9
	button_editor.reset_tween(self)
	tween.tween_property(self, "scale", Vector2(1.3,1.3), 0.09)
	tween.tween_property(self, "modulate:a", 0.0, 0.1)

	tween.chain().tween_callback(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
