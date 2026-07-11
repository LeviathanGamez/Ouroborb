extends Node2D


@onready var animation_player = $HitFlashAnimationPlayer
@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_player2 = $AudioStreamPlayer2D2
@export var stats: tile_types
var money_text = preload("res://scenes/money.tscn")
var copy_tile = preload("res://scenes/copy_tile.tscn")

var tile_type
var tile_type_mult
var value = 5
var crit
var power
var crit_power
var tile_value
var crit_value

func _ready() -> void:
	
	add_to_group("Colliders")
	set_up_variables()
	value = stats.value

func _process(_delta: float) -> void:
	label.text = str(value)
	if value <= 0:
		kill()


func set_up_variables():
	crit = GlobalGameManager.player_crit + GlobalGameManager.global_click_crit
	power = int(round(GlobalGameManager.player_strength + GlobalGameManager.global_click_power))
	crit_power = power * GlobalGameManager.player_crit_mult * GlobalGameManager.global_click_crit_power
	tile_value = int(round(GlobalGameManager.player_value + GlobalGameManager.global_tile_worth))
	crit_value = tile_value * GlobalGameManager.player_crit_mult * GlobalGameManager.global_click_crit_power
	power = power * GlobalGameManager.global_click_mult * GlobalGameManager.global_tough_click
	crit_power = crit_power * GlobalGameManager.global_click_mult  * GlobalGameManager.global_tough_click
	tile_value = int(round(tile_value * stats.tile_type_mult * GlobalGameManager.global_click_worth * GlobalGameManager.global_money_mult))
	crit_value = int(round(crit_value * stats.tile_type_mult *GlobalGameManager.global_click_worth * GlobalGameManager.global_money_mult))
	sprite.texture = stats.texture
	
func _on_button_pressed() -> void:
	if randf() < crit:
		GlobalGameManager.add_count(crit_value)
		value -= crit_power
		sprite.material.set_shader_parameter("Tint", Color.html("EFBF04"))
		audio_player2.pitch_scale = randf_range(0.9,1.25)
		audio_player2.play()
		##money animation
		var money_a = money_text.instantiate()
		get_tree().current_scene.get_node("Money_texts").add_child(money_a)
		money_a.global_position = global_position
		crit_value = int(round(crit_value))
		money_a.get_node("RichTextLabel").text = "+"+str(crit_value)+"$"
		if value <= 0:
			var sound = audio_player2.duplicate()
			get_tree().current_scene.add_child(sound)

			sound.global_position = global_position
			sound.play()
			sound.finished.connect(sound.queue_free)

			kill()
		
	else:
		sprite.material.set_shader_parameter("Tint", Color.WHITE)
		value -= power
		GlobalGameManager.add_count(tile_value)
		audio_player.pitch_scale= randf_range(0.9,1.25)
		audio_player.play()
		#money animation
		var money_a = money_text.instantiate()
		get_tree().current_scene.get_node("Money_texts").add_child(money_a)
		money_a.global_position = global_position
		tile_value = int(round(tile_value))
		money_a.get_node("RichTextLabel").text = "+"+str(tile_value)+"$"
		if value <= 0:
			var sound = audio_player.duplicate()
			get_tree().current_scene.add_child(sound)

			sound.global_position = global_position
			sound.play()
			sound.finished.connect(sound.queue_free)

			kill()
			
	animation_player.play("hit_flash")

func kill():
	var explosion = copy_tile.instantiate()
	explosion.modulate = sprite.modulate
	get_tree().current_scene.add_child(explosion)

	explosion.global_position = global_position

	explosion.get_node("Sprite2D").modulate = modulate
	queue_free()
