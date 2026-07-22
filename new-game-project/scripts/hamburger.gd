extends Button

@onready var GameManager = $"../../GameManager"

@onready var settings = $"../../Settings"
var activated = false
@onready var hslider = $"../../Settings/Volume"

@onready var music_slider = $"../../Settings/Music"
@onready var sfx_slider = $"../../Settings/SFX"
var music = AudioServer.get_bus_index("Music")
var sfx = AudioServer.get_bus_index("SFX")
@onready var UI = $"../../UI"
@onready var add_ball = $"../../Buttons/Control/Add Ball Button"
@onready var upgrades = $"../../Buttons/Control2/Upgrades Button"
@onready var merge = $"../../Buttons/Control3/Merge Button"
func _ready():

	settings.visible = false
	for child in settings.get_children():
			child.visible = false
	
	var volume_db = AudioServer.get_bus_volume_db(0)
	hslider.value = db_to_linear(volume_db) * 100
	music_slider.value =  db_to_linear(AudioServer.get_bus_volume_db(music))*100
	sfx_slider.value =  db_to_linear(AudioServer.get_bus_volume_db(sfx))*100
	disable_buttons(activated)
	
func _on_pressed() -> void:
	if not UI.visible:
		settings.visible = true
		for child in settings.get_children():
			child.visible = true
		disable_buttons(true)
		add_ball.mouse_filter = Control.MOUSE_FILTER_IGNORE
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		upgrades.mouse_filter = Control.MOUSE_FILTER_IGNORE
		merge.mouse_filter = Control.MOUSE_FILTER_IGNORE
		get_tree().paused = true
	
func disable_buttons(activated):
	disabled = activated
	add_ball.disabled = activated
	upgrades.disabled = activated
	merge.disabled = activated


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(value/100)) 


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value / 100)) 


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value / 100)) 
