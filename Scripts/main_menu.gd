extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Global.game_controller.paused = false
	Global.game_controller.startGameMusic()
	Global.game_controller.change_2d_scene("res://Level/LEVEL_1.tscn")


func _on_options_pressed() -> void:
	Global.game_controller.change_gui_scene("res://GUI/Admin.tscn")

func _on_Exit_pressed() -> void:
	get_tree().quit()


func _on_Options_Game_pressed() -> void:
	Global.game_controller.change_gui_scene("res://GUI/options_menu.tscn")
