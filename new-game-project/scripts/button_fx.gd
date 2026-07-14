extends Button
class_name ButtonFX
var button_editor = preload("res://scripts/tweens.gd")
var tween 


var particle_click = preload("res://scenes/particles_click.tscn")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	pivot_offset = size/2



func _on_mouse_entered() -> void:
	button_editor.expand(self)


func _on_mouse_exited() -> void:
	button_editor.shrink(self)


func _on_pressed() -> void:
	for i in range(0,GlobalGameManager.amount):
		var particle_a = particle_click.instantiate()
		particle_a.rotation  =  (i * GlobalGameManager.angle)
		particle_a.get_node("CPUParticles2D").emitting = true
		particle_a.global_position = get_global_mouse_position()
		
		if get_tree() != null:
			get_tree().current_scene.get_node("Particles").add_child(particle_a)

			
