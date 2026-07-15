extends ButtonFX

@onready var settings = $"../../Settings"
var activated = false
@onready var hslider = $"../../Settings/Volume"

@onready var music_slider = $"../../Settings/Music"
@onready var sfx_slider = $"../../Settings/SFX"
var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("SFX")
@onready var credit_button = $"../../Control4/Credit Button"
@onready var start_button = $"../../Control/Start Button"
@onready var quit_button = $"../../Control3/Quit Button"
func _ready():
	super._ready()

	settings.visible = false
	for child in settings.get_children():
			child.visible = false
	
	var volume_db = AudioServer.get_bus_volume_db(0)
	hslider.value = db_to_linear(volume_db) * 100
	music_slider.value =  db_to_linear(AudioServer.get_bus_volume_db(music))*100
	sfx_slider.value =  db_to_linear(AudioServer.get_bus_volume_db(sfx))*100
	disable_buttons(activated)
	
func _on_pressed() -> void:
	super._on_pressed()
	settings.visible = true
	for child in settings.get_children():
		child.visible = true
	disable_buttons(true)
	credit_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	start_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	quit_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func disable_buttons(activated):
	disabled = activated
	credit_button.disabled = activated
	start_button.disabled = activated
	quit_button.disabled = activated


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(value/100)) 


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value / 100))


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value / 100))
