extends Button

var button_editor = preload("res://scripts/tweens.gd")
var tween = create_tween()
@onready var camera = $"../../Camera2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)# Replace with function body.


func _on_pressed() -> void:
	camera.zoom_in(self) # Replace with function body.
