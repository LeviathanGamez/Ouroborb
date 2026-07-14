extends Control

var tween 
var button_editor = preload("res://scripts/tweens.gd")
@onready var text_label = $RichTextLabel

func _ready() -> void:
	
	button_editor.reset_tween(self)
	tween.tween_property(text_label,"scale",Vector2(1.8,1.8),0.2)
	tween.tween_property(text_label,"scale",Vector2(0,0),0.2).set_delay(0.2)
	tween.parallel().tween_property(text_label,"position",Vector2(text_label.global_position.x,text_label.global_position.y-40),0.4)
	
	
