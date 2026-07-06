extends Node

var tween = create_tween()
static func reset_tween(node)->void:
	if node.tween:
		node.tween.kill()
	node.tween = node.create_tween()
# Called when the node enters the scene tree for the first time.
static func expand(node):
	
	reset_tween(node)
	node.tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	node.tween.tween_property(node, "scale", Vector2(1.2,1.2) , 0.3)
	
static func shrink(node):
	reset_tween(node)
	node.tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	node.tween.tween_property(node, "scale", Vector2(1,1) , 0.2)
