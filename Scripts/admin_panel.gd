extends Control

@export var StatusLabel: Label 
@export var PathTextBox:LineEdit

@onready var admin: Control = $"."
var dir:DirAccess
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = DirAccess.open("res://")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	if admin.has_meta("previous"):
		Global.game_controller.change_gui_scene(admin.get_meta("previous"))
	else:
		Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")

func _check_path(path:String)->bool:
	if dir:
		if dir.file_exists(path):
			StatusLabel.text = "path exists"
			return true
	StatusLabel.text = "No such path"
	return false



func _on_Load_2d_Scene_pressed() -> void:
	Global.game_controller.load_level(PathTextBox.text.to_int())

func _on_Load_GUI_Scene_pressed() -> void:
	var result = _check_path(PathTextBox.text)
	if result:
		Global.game_controller.change_gui_scene(PathTextBox.text)
