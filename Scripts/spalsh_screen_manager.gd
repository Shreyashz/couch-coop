extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Global.game_controller.change_gui_scene("res://GUI/PauseMenu.tscn")
	if event.is_action_pressed("AdminTrigger"):
		Global.game_controller.change_gui_scene("res://GUI/Admin.tscn")
