extends Button

var button_editor = preload("res://scripts/tweens.gd")
var tween = create_tween()
@onready var camera = $"../../../Camera2D"
@onready var UI = $"../../../UI"
# Called when the node enters the scene tree for the first time.
var particle_click = preload("res://scenes/particles_click.tscn")

func _ready() -> void:
	pass # Replace with function body.



func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)# Replace with function body.


func _on_pressed() -> void:
	camera.zoom_in(self) # Replace with function body.
	GlobalGameManager.toggle_pause(UI)
	for i in range(0,GlobalGameManager.amount):
		var particle_a = particle_click.instantiate()
		particle_a.rotation  =  (i * GlobalGameManager.angle)
		particle_a.get_node("CPUParticles2D").emitting = true
		particle_a.global_position = get_global_mouse_position()
		get_tree().current_scene.get_node("Particles").add_child(particle_a)
	
