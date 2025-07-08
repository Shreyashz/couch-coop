class_name gameController extends Node
@export var world2d:Node2D
@export var gui:Control

var current_2d_scene
var current_gui_scene

func _ready() -> void:
	Global.game_controller = self
	Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")

func change_gui_scene(new_scene:String, delete:bool = true, keep_running:bool=false)->void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func change_2d_scene(new_scene:String, delete:bool = true, keep_running:bool=false)->void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			world2d.remove_child(current_2d_scene)
	var new = load(new_scene).instantiate()
	world2d.add_child(new)
	current_2d_scene = new
