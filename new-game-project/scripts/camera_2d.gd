extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var tween = create_tween()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func animation():
	print("ye")
	tween.tween_property(self,"position",Vector2(0,-80),0.1)
	
