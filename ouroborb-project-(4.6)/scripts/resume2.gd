extends ButtonFX

@onready var settings = $".."
@onready var hamburger = $"../../Hamburger/hamburger"
@onready var add_ball = $"../../Buttons/Control/Add Ball Button"
@onready var upgrades = $"../../Buttons/Control2/Upgrades Button"
@onready var merge = $"../../Buttons/Control3/Merge Button"
func _ready():
	super._ready()
	
func _on_pressed() -> void:
	super._on_pressed()
	settings.visible = false
	add_ball.disabled = false
	upgrades.disabled = false
	merge.disabled = false
	hamburger.disabled = false
	hamburger.mouse_filter = Control.MOUSE_FILTER_STOP
	add_ball.mouse_filter = Control.MOUSE_FILTER_STOP
	upgrades.mouse_filter = Control.MOUSE_FILTER_STOP
	merge.mouse_filter = Control.MOUSE_FILTER_STOP
	
