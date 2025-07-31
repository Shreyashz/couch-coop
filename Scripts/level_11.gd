extends Node2D

func _on_Exit_2_Menu_pressed() -> void:
	Global.game_controller.change_2d_scene("res://Level/mainMenuBG.tscn")
	Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")
	Global.game_controller.play_sfx("Click")
