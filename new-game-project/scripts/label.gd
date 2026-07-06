extends Label

var tween = create_tween()
var tween_dollar = create_tween()
var pos 
var button_editor = preload("res://scripts/tweens.gd")
@onready var dollar = $"../DollarSign"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#princess treatment
	GlobalGameManager.label = $"."
	pos = dollar.global_position
	

func activate_tweens():
	#self
	tween.tween_property(self,"scale",Vector2(1,1),0.000001)
	button_editor.reset_tween(self)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(1.05,1.05),0.05)
	tween.tween_property(self,"scale",Vector2(1,1),0.1).set_delay(0.05)
	#dollar
	if tween_dollar:
		tween_dollar.kill()
		tween_dollar = create_tween()
		tween_dollar.set_ease(Tween.EASE_OUT)
		tween_dollar.tween_property(dollar, "position", pos-Vector2(0,10), 0.1)
		tween_dollar.tween_property(dollar, "position", pos, 0.1).set_delay(0.05)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pivot_offset = size / 2
