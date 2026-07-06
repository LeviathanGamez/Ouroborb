extends Node2D

@export var value = 5
@onready var animation_player = $HitFlashAnimationPlayer
@onready var label = $Label
@onready var sprite = $Sprite2D
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
		#hitflash
	else:
		sprite.material.set_shader_parameter("Tint", Color.WHITE)
		value -= GlobalGameManager.player_strength
		GlobalGameManager.add_count(GlobalGameManager.player_value)
	animation_player.play("hit_flash")
