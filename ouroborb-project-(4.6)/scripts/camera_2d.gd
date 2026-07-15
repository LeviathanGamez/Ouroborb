extends Camera2D

var tween 

var button_editor = preload("res://scripts/tweens.gd")
var pos
var zoomin
var t = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = global_position
func _process(delta):
	if zoomin and GlobalGameManager.screenshake:
		zoom = lerp(zoom,Vector2(1-0.02,1-0.02),0.09)
		t += delta
		if t >= 0.25:
			zoomin = false
			t = 0.0
	else:
		zoom = lerp(zoom,Vector2(1,1),0.15)
	
func zoom_in(_node):
	#button_editor.reset_tween(self)
	#tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.tween_property(self, "position", pos+Vector2(node.global_position.x-pos.x,node.global_position.y-pos.y).normalized()*2, 0.1)
	zoomin = true
	
	#tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#tween.tween_property(self, "position", pos, 0.1).set_delay(0.1)
