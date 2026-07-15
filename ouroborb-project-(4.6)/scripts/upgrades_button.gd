extends Button

var button_editor = preload("res://scripts/tweens.gd")
var tween 
@onready var camera = $"../../../Camera2D"
@onready var UI = $"../../../UI"

var particle_click = preload("res://scenes/particles_click.tscn")





func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)


func _on_pressed() -> void:
	camera.zoom_in(self) 
	GlobalGameManager.toggle_pause(UI)
	for i in range(0,GlobalGameManager.amount):
		var particle_a = particle_click.instantiate()
		particle_a.rotation  =  (i * GlobalGameManager.angle)
		particle_a.get_node("CPUParticles2D").emitting = true
		particle_a.global_position = get_global_mouse_position()
		get_tree().current_scene.get_node("Particles").add_child(particle_a)
	
