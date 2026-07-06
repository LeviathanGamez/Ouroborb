extends Button



var button_editor = preload("res://scripts/tweens.gd")
var tween = create_tween()
@onready var camera = $"../../../Camera2D"

var particle_scene = preload("res://scenes/particles.tscn")
var particle

var lvl_1 = preload("res://resources/level_1.tres")
var lvl_2 = preload("res://resources/level_2.tres")
var lvl_3 = preload("res://resources/level_3.tres")
var lvl_4 = preload("res://resources/level_4.tres")
var lvl_5 = preload("res://resources/level_5.tres")
var levels = [lvl_1,lvl_2,lvl_3,lvl_4,lvl_5]

var do_we_break = false
var balls

func _on_pressed() -> void:
	
	balls = get_tree().get_nodes_in_group("balls")
	for level in levels:
		for i in range(len(balls)):
			for j in range(i,len(balls)):
				if (i==j):
					continue
				if balls[i].stats == balls[j].stats:
					if balls[i].stats != lvl_5:
						if balls[i].stats == level:
							balls[i].stats = levels[levels.find(balls[i].stats)+1]
							balls[i].set_up_variables()
							
							particle = particle_scene.instantiate()
							balls[i].add_child(particle)
							particle.global_position = balls[i].global_position
							var particle_a = particle.get_node("CPUParticles2D")
							particle_a.restart()
							particle_a.emitting = true
							
							balls[j].queue_free()
							do_we_break = true
							
							var merged = balls.pop_at(i)
							balls.append(merged)
							break
			if do_we_break:
				break
		if do_we_break:
			break
	
	do_we_break = false
	camera.zoom_in(self)



func _on_mouse_entered() -> void:
	button_editor.expand(self)
	

func _on_mouse_exited() -> void:
	button_editor.shrink(self)# Replace with function body.
