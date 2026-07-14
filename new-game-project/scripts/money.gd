extends Control

var tween 
var button_editor = preload("res://scripts/tweens.gd")
@onready var text_label = $RichTextLabel

func play_animation() -> void:
	
	text_label.scale = Vector2.ONE
	text_label.pivot_offset = text_label.size / 2
	button_editor.reset_tween(self)
	tween.tween_property(text_label,"scale",Vector2(1.8,1.8),0.2)
	tween.tween_property(text_label,"scale",Vector2(0,0),0.2).set_delay(0.2)
	tween.parallel().tween_property(text_label, "position:y", -40, 0.4)
	
	await tween.finished
	visible = false
	
