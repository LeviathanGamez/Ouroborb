extends Node2D

@export var value = 5
@onready var animation_player = $HitFlashAnimationPlayer
@onready var label = $Label
@onready var sprite = $Sprite2D
@onready var audio_player = $AudioStreamPlayer2D
@onready var audio_player2 = $AudioStreamPlayer2D2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Colliders")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(value)
	if value <= 0:
		queue_free()



func _on_button_pressed() -> void:
	if randf() < GlobalGameManager.player_crit:
		GlobalGameManager.add_count(GlobalGameManager.player_value*GlobalGameManager.player_crit_mult)
		value -= GlobalGameManager.player_strength * GlobalGameManager.player_crit_mult
		sprite.material.set_shader_parameter("Tint", Color.html("EFBF04"))
		audio_player2.pitch_scale= randf_range(0.9,1.25)
		audio_player2.play()
		#hitflash
	else:
		sprite.material.set_shader_parameter("Tint", Color.WHITE)
		value -= GlobalGameManager.player_strength
		GlobalGameManager.add_count(GlobalGameManager.player_value)
		audio_player.pitch_scale= randf_range(0.9,1.25)
		audio_player.play()
	animation_player.play("hit_flash")
