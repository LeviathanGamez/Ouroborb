
extends ButtonFX
var diamond_shader = preload("res://scenes/diamond_shader.tscn")

func _on_pressed() -> void:
	super._on_pressed()
	var shader_a = diamond_shader.instantiate()
	get_tree().current_scene.add_child(shader_a)
	shader_a.get_node("ColorRect").material.set_shader_parameter("progress", 0.0)

	var tween = create_tween()
	tween.tween_method(
		func(value): shader_a.get_node("ColorRect").material.set_shader_parameter("progress", value),
		0.0,
		1.0,
		1.5
	)

	await tween.finished
	
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/credits.tscn") # Replace with function body.
	
