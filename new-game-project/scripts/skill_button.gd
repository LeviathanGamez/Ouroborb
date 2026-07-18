@tool
extends TextureButton
class_name Skill_Node

@onready var label = $MarginContainer/Label
@onready var panel = $Panel
@onready var sprite = $Sprite2D
@onready var tooltip = $Tooltip
@onready var panel_container = $Tooltip/PanelContainer
@onready var text_label = $Tooltip/PanelContainer/RichTextLabel
@onready var line_2d: Line2D = $Line2D
@onready var max_rect = $ColorRect

	
@export var stats: upgrade_stats
var max_level = 5
@export var price := 10
var original_price

var particle_click = preload("res://scenes/particles_click.tscn")
var button_editor = preload("res://scripts/tweens.gd")

var tween 
var tween_2 
var tween_3
var tween_4 


enum GrowthType{
	FAST,
	MEDIUM,
	SLOW,
		
}
var price_list = {
	GrowthType.FAST: [1.5,2,5,7,10] ,
	GrowthType.MEDIUM: [1.5,2,3,5,10],
	GrowthType.SLOW: [1.5,2,4,6,8]
}
var price_increment
@export var price_type : GrowthType

var current_price_increment = 0


func _ready():
	add_to_group("Buttons")
	price_increment = price_list[price_type]
	check_prices()
	await get_tree().process_frame
	tooltip.visible = true
	tooltip.modulate.a = 0
	panel_container.size.x = tooltip.size.x
	tooltip.visible = true
	panel_container.visible = true
	text_label.visible = true
	
	var skill = get_parent()
	if skill is Skill_Node:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(skill.global_position + size/2)
	if stats != null:
		sprite.texture = stats.texture
	label.text = str(level) + "/" + str(max_level)
	pivot_offset = size/2
	
	if disabled:
		modulate.a = 0
		line_2d.modulate.a = 0
	update_text()
	tooltip.size.y = panel_container.size.y
	



	
var level := 0:
	set(value):
		level = value
		label.text = str(level) + "/" + str(max_level)
		
func _process(_delta):
		
	if not Engine.is_editor_hint():
		tooltip.global_position = get_global_mouse_position() + Vector2(-tooltip.size.x/2, size.y/2)
		tooltip.size.y = panel_container.size.y
	if Engine.is_editor_hint():
		modulate.a = 1
		
		if stats != null:
			sprite.texture = stats.texture
		text_label.text = " "
		#tooltip.size.y = 0
	

	
	
func _on_pressed() -> void:
	if GlobalGameManager.money >= price and level < max_level:
		GlobalGameManager.add_count(-price)
		price = int(round(original_price * price_increment[current_price_increment]))
		current_price_increment = min(current_price_increment + 1,price_increment.size()-1)
		
		GlobalGameManager.set(
			stats.stat_map[stats.stat],
			GlobalGameManager.get(stats.stat_map[stats.stat]) + stats.value)
			
		
		level = min(level+1,max_level) 
		
		if tween_2:
			tween_2.kill()
		tween_2 = create_tween()
		tween_2.tween_property(panel, "self_modulate:a", 0.0, 0.9)
		line_2d.z_index = 11
		tween_2.parallel().tween_property(line_2d, "default_color", Color(0.93, 0.93, 0.93, 1.0), 0.9)
		
		if tween_4:
			tween_4.kill()
		tween_4 = create_tween()
		
		var skills = get_children()
		for skill in skills:
			if skill is Skill_Node and level == 1:
				skill.disabled = false
				tween_4.parallel().tween_property(skill, "self_modulate:a", 1.0, 0.3)
				tween_4.parallel().tween_property(skill, "modulate:a", 1.0, 0.3)
				tween_4.parallel().tween_property(skill.get_node("Line2D"), "modulate:a", 1.0, 0.5)
		
		#GlobalGameManager.print_stats()
		var colliders = get_tree().get_nodes_in_group("Colliders")
		var balls = get_tree().get_nodes_in_group("balls")
		for ball in balls:
			ball.set_up_variables()
		for collider in colliders:
			collider.set_up_variables()
	
	
	for i in range(0,GlobalGameManager.amount):
		var particle_a = particle_click.instantiate()
		particle_a.rotation  =  (i * GlobalGameManager.angle)
		particle_a.get_node("CPUParticles2D").emitting = true
		particle_a.global_position = get_global_mouse_position()
		get_tree().current_scene.get_node("Particles").add_child(particle_a)
	if not disabled:
		self_modulate.a = 1
		modulate.a = 1
	update_text()
	for button in get_tree().get_nodes_in_group("Buttons"):
		if button.stats.StatType == stats.StatType:
			button.update_text()

func update_text():
	var global_stat 
	var added_value
	var total_value
	if str(stats.StatType.keys()[stats.stat].to_lower()).replace("_", " ").to_upper() in ["BALL POWER","CLICK POWER",]:
		global_stat= ceil(GlobalGameManager.get(stats.stat_map[stats.stat]))
		added_value = ceil(stats.value)
		total_value = GlobalGameManager.numberphy(floor(global_stat+added_value+1))
		global_stat = GlobalGameManager.numberphy(global_stat+1) 
		
	else:
		global_stat = ceil(GlobalGameManager.get(stats.stat_map[stats.stat]) * 100)
		added_value = ceil(stats.value * 100)
		total_value = GlobalGameManager.numberphy(floor(global_stat+added_value)) + "%"
		global_stat = GlobalGameManager.numberphy(global_stat) + "%"
	if level != max_level:
		text_label.text = (
			"[center]" +
			str(stats.StatType.keys()[stats.stat].to_lower()).replace("_", " ").to_upper() +
			"[/center]\n\n" +
			"[center]" + stats.text + "[/center]\n\n" +
			"[center]" + global_stat + " -> " + total_value + "[/center]\n\n" +
			"[center][color=#EFBF04]Cost: $" + GlobalGameManager.numberphy(price) + "[/color][/center]"
		)
	else:
		max_rect.visible = true
		var style := tooltip.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
		style.border_color = Color.html("#EFBF04")
		tooltip.add_theme_stylebox_override("panel", style)
	
		text_label.text = (
			"[center]" +
			str(stats.StatType.keys()[stats.stat].to_lower()).replace("_", " ").to_upper() +
			"[/center]\n\n" +
			"[center]" + stats.text + "[/center]\n\n" +
			"[center][color=#EFBF04] MAX LEVEL[/color][/center]"
		)
	#text_label.reset_size()
	#panel_container.reset_size()
	

func check_prices():
	original_price = price
	if max_level == 10:
		price_increment = [1.5,2,2.5,3,4,5,7.5,8,10]
		
func _on_mouse_entered() -> void:
	reset_tween()
	if tween_3:
		tween_3.kill()
	tween_3 = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2(3*1.1,3*1.1) , 0.3)
	tween.parallel().tween_property(panel, "scale", Vector2(1.15,1.15), 0.3)
	tween_3.tween_property(tooltip,"modulate:a",1.0,0.3)


	
func _on_mouse_exited() -> void:
	reset_tween()
	if tween_3:
		tween_3.kill()
	tween_3 = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2(3,3) , 0.2)
	tween.parallel().tween_property(panel, "scale", Vector2(1,1) , 0.3)
	tween_3.tween_property(tooltip,"modulate:a",0,0.2)
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
