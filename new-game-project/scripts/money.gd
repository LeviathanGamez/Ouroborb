extends Control

var tween = create_tween()
var button_editor = preload("res://scripts/tweens.gd")
@onready var text_label = $RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	button_editor.reset_tween(self)
	tween.tween_property(text_label,"scale",Vector2(1.6,1.6),0.2)
	tween.tween_property(text_label,"scale",Vector2(0,0),0.2).set_delay(0.2)
	tween.parallel().tween_property(text_label,"position",Vector2(text_label.global_position.x,text_label.global_position.y-40),0.4)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
