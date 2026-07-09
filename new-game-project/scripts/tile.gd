extends Node2D

@export var value = 5
@onready var animation_player = $HitFlashAnimationPlayer
@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_player2 = $AudioStreamPlayer2D2

var crit
var power
var crit_power
var tile_value

func _ready() -> void:
	add_to_group("Colliders")
	set_up_variables()

func _process(_delta: float) -> void:
	label.text = str(value)
	if value <= 0:
		queue_free()


func set_up_variables():
	
	crit = GlobalGameManager.player_crit * GlobalGameManager.global_click_crit
	power = int(round(GlobalGameManager.player_strength + GlobalGameManager.global_click_power))
	crit_power = GlobalGameManager.player_strength * GlobalGameManager.player_crit_mult * GlobalGameManager.global_click_crit_power
	tile_value = int(round(GlobalGameManager.player_value + GlobalGameManager.global_tile_worth))
	
func _on_button_pressed() -> void:
	if randf() < crit:
		GlobalGameManager.add_count(crit_power)
		value -= crit_power
		sprite.material.set_shader_parameter("Tint", Color.html("EFBF04"))
		audio_player2.pitch_scale= randf_range(0.9,1.25)
		audio_player2.play()
		#hitflash
	else:
		sprite.material.set_shader_parameter("Tint", Color.WHITE)
		value -= power
		GlobalGameManager.add_count(tile_value)
		audio_player.pitch_scale= randf_range(0.9,1.25)
		audio_player.play()
	animation_player.play("hit_flash")
