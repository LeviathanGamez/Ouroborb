extends ButtonFX

var activated = false
@onready var ball_merge_stats = $"../ball_merge_stats"
func _on_pressed() -> void:
	if ball_merge_stats.visible:
		activated = true
	else:
		activated = false
	get_tree().paused = not activated
	ball_merge_stats.visible = not activated
	ball_merge_stats.z_index = 1000
	activated = not activated
