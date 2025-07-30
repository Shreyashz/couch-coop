extends Control
@onready var master_slider: HSlider = $VBoxContainer/MasterSlider
@onready var music_slider: HSlider = $VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $VBoxContainer/SfxSlider
@onready var menu_slider: HSlider = $VBoxContainer/MenuSlider

func _ready() -> void:
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	menu_slider.value = db_to_linear(AudioServer.get_bus_volume_db(3))

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(master_slider.value))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(music_slider.value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_slider.value))


func _on_menu_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3, linear_to_db(menu_slider.value))


func _on_button_2_pressed() -> void:
	Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")
