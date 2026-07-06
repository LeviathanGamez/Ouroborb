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
	node.tween.parallel().tween_property(node,"rotation_degrees",3 * [-1,1].pick_random(),0.1)
	node.tween.parallel().tween_property(node,"rotation_degrees",0.0,0.1).set_delay(0.1)
	
static func shrink(node):
	reset_tween(node)
	node.tween.parallel().tween_property(node,"rotation_degrees",0.0,0.0001)
	node.tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	node.tween.tween_property(node, "scale", Vector2(1,1) , 0.2)
