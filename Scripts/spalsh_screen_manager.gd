extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not Global.game_controller.paused:
			Global.game_controller.pause()
			Global.game_controller.change_gui_scene("res://GUI/PauseMenu.tscn")
		else:
			if Global.game_controller.current_gui_scene.has_meta("return"):
				if Global.game_controller.current_gui_scene.get_meta("return"):
					Global.game_controller.unpause()
					Global.game_controller.change_gui_scene("res://GUI/InGameUI.tscn")
			elif Global.game_controller.current_gui_scene.has_meta("previous"):
				Global.game_controller.change_gui_scene(Global.game_controller.current_gui_scene.get_meta("previous"))
	if event.is_action_pressed("AdminTrigger"):
		Global.game_controller.change_gui_scene("res://GUI/Admin.tscn")
