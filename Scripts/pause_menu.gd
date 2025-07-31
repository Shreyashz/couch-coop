extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_Exit_2_Menu_pressed() -> void:
	Global.game_controller.change_2d_scene("res://Level/mainMenuBG.tscn")
	Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")
	Global.game_controller.play_sfx("Click")

func _on_options_pressed() -> void:
	Global.game_controller.change_gui_scene("res://GUI/options_menu.tscn")
	Global.game_controller.play_sfx("Click")

func _on_Continue_pressed() -> void:
	Global.game_controller.change_gui_scene("res://GUI/InGameUI.tscn")
	Global.game_controller.unpause()
	Global.game_controller.play_sfx("Click")
