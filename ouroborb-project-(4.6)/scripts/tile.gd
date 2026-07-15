extends Node2D


@onready var animation_player = $HitFlashAnimationPlayer
@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_player2 = $AudioStreamPlayer2D2
var sound
var sound2

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
	if audio_player and audio_player.stream:
		audio_player.stream = audio_player.stream.duplicate()
	if audio_player2 and audio_player2.stream:
		audio_player2.stream = audio_player2.stream.duplicate()
	sound = audio_player.duplicate()
	sound2 = audio_player2.duplicate()

func _process(_delta: float) -> void:
	label.text = str(int(value))
	if value <= 0:
		kill()


func set_up_variables():
	crit = GlobalGameManager.player_crit + GlobalGameManager.global_click_crit
	power = int(round(GlobalGameManager.player_strength + GlobalGameManager.global_click_power))
	crit_power = power * GlobalGameManager.player_crit_mult * GlobalGameManager.global_click_crit_power
	tile_value = int(round(GlobalGameManager.player_value + GlobalGameManager.global_tile_worth))
	crit_value = tile_value * GlobalGameManager.player_crit_mult * GlobalGameManager.global_click_crit_power
	power = power * GlobalGameManager.global_click_mult 
	crit_power = crit_power * GlobalGameManager.global_click_mult  
	tile_value = int(round(tile_value * stats.tile_type_mult * GlobalGameManager.global_click_worth * GlobalGameManager.global_money_mult))
	crit_value = int(round(crit_value * stats.tile_type_mult *GlobalGameManager.global_click_worth * GlobalGameManager.global_money_mult))
	if stats.type == 1:
		tile_value = int(round(tile_value * GlobalGameManager.global_gold_mult))
		crit_value = int(round(crit_value * GlobalGameManager.global_gold_mult))
	elif stats.type == 2:
		tile_value = int(round(tile_value * GlobalGameManager.global_diamond_mult))
		crit_value = int(round(crit_value * GlobalGameManager.global_diamond_mult))
	sprite.texture = stats.texture
	
func _on_button_pressed() -> void:
	if randf() < crit:
		GlobalGameManager.add_count(crit_value)
		value -= crit_power
		sprite.material.set_shader_parameter("Tint", Color.html("EFBF04"))
		play_sound(audio_player2)
		#money animation
	
		crit_value = int(round(crit_value))
		spawn_text_pooled(crit_value)
		
		if value <= 0:
			
			if sound2.playing:
				sound2.stop()
			
			get_tree().current_scene.add_child(sound2)

			sound2.global_position = global_position
			sound2.play()
			sound2.finished.connect(sound2.queue_free)

			kill()
		
	else:
		sprite.material.set_shader_parameter("Tint", Color.WHITE)
		value -= power
		GlobalGameManager.add_count(tile_value)
		play_sound(audio_player)
		#money animation
		
		tile_value = int(round(tile_value))
		spawn_text_pooled(tile_value)
		if value <= 0:
			if sound.playing:
				sound.stop()
			get_tree().current_scene.add_child(sound)

			sound.global_position = global_position
			sound.play()
			sound.finished.connect(sound.queue_free)

			kill()
			
	animation_player.play("hit_flash")
func spawn_text_pooled(value):
	var money_text = GlobalGameManager.label_pool[GlobalGameManager.label_pool_index]
	money_text.visible = true
	GlobalGameManager.label_pool_index = wrap(GlobalGameManager.label_pool_index + 1,0,GlobalGameManager.max_label_count)
	money_text.global_position = global_position
	money_text.get_node("RichTextLabel").text = "+"+str(int(round(value)))+"$"
	money_text.play_animation()
	
func play_sound(audio):
	if audio.playing and audio.get_playback_position() <= 0.05:
		return

	if audio.playing:
		audio.stop()

	audio.pitch_scale = randf_range(0.9, 1.25)
	audio.play()
func kill():
	var explosion = copy_tile.instantiate()
	explosion.modulate = sprite.modulate
	get_tree().current_scene.add_child(explosion)

	explosion.global_position = global_position

	explosion.get_node("Sprite2D").modulate = modulate
	queue_free()
