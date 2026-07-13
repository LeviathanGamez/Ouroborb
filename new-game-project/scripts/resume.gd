extends ButtonFX

@onready var settings = $".."
@onready var start_button: Button = $"../../Control/Start Button"
@onready var options_button: Button = $"../../Control2/Options Button"
@onready var quit_button: Button = $"../../Control3/Quit Button"
@onready var credit_button: Button = $"../../Control4/Credit Button"

func _ready():
	super._ready()
	
func _on_pressed() -> void:
	super._on_pressed()
	settings.visible = false
	start_button.disabled = false
	options_button.disabled = false
	quit_button.disabled = false
	credit_button.disabled = false
	start_button.mouse_filter = Control.MOUSE_FILTER_STOP
	options_button.mouse_filter = Control.MOUSE_FILTER_STOP
	quit_button.mouse_filter = Control.MOUSE_FILTER_STOP
	credit_button.mouse_filter = Control.MOUSE_FILTER_STOP
	
