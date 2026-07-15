
extends Button

@onready var UI = $"../.."


func _on_pressed() -> void:
	GlobalGameManager.toggle_pause(UI)
