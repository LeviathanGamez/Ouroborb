extends Node2D

@onready var staticbody = $StaticBody2D/CollisionShape2D
var selected = false
var one_time = true
var can_be_placed = true
var TILE_SIZE = Vector2(16,16)

func _ready():
	add_to_group("diamonds")
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("Click"):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if one_time:
					selected = true
					one_time = true
				staticbody.set_deferred("disabled", true)
		
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position,get_global_mouse_position(),25*delta)
	

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
				if can_be_placed:
					selected = false
					global_position = get_global_mouse_position().snapped(TILE_SIZE)+Vector2(9,0)
					staticbody.set_deferred("disabled", false)


func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("diamonds") and body.get_parent() != self:
		can_be_placed = false  # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("diamonds") and body.get_parent() != self:
		can_be_placed = true
