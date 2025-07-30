class_name gameController extends Node

const FILE_BEGIN = "res://Level/LEVEL_"
const mainmenu_path = "res://GUI/Main_menu.tscn"

@export var world2d:Node2D
@export var gui:Control
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $MusicStreamPlayer2D
@onready var SFX_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var menu_stream_player_2d_2: AudioStreamPlayer2D = $MenuStreamPlayer2D2
const JUMP_SOUND = preload("res://Music and sounds/JumpSound.mp3")
var first_player_ready:bool
var current_2d_scene:Node2D
var path_current_2d_scene:String
var current_gui_scene:Control
var curr_gui_path:String
var paused:bool

func _ready() -> void:
	Global.game_controller = self
	Global.game_controller.change_gui_scene("res://GUI/Main_menu.tscn")
	Global.game_controller.paused = true
	

func play_sfx(sfx:String)-> void:
	match sfx:
		"jump":
			SFX_stream_player.stream = JUMP_SOUND
			SFX_stream_player.play()

func pause():
	Global.game_controller.paused = true
	current_2d_scene.process_mode = PROCESS_MODE_DISABLED
func unpause():
	Global.game_controller.paused = false
	current_2d_scene.process_mode = PROCESS_MODE_INHERIT

func change_guiPos(newPosition:Vector2):
	gui.global_position = newPosition

func change_gui_scene(new_scene:String, delete:bool = true, keep_running:bool=false)->void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	var new:Control = load(new_scene).instantiate()
	gui.add_child(new)
	if current_gui_scene:
		new.set_meta("previous", current_gui_scene.scene_file_path)
	current_gui_scene = new
	if new_scene == mainmenu_path && !menu_stream_player_2d_2.playing:
		menu_stream_player_2d_2.playing = true
		audio_stream_player_2d.playing = false
	elif new_scene == mainmenu_path:
		audio_stream_player_2d.playing = false
	curr_gui_path = new_scene

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
	path_current_2d_scene = new_scene
	current_2d_scene = new
	first_player_ready = false
	if current_2d_scene.has_meta("LEVEL"):
		change_gui_scene("res://GUI/InGameUI.tscn")

func load_level(level_no:int):
	var next_level_path = FILE_BEGIN + str(level_no) + ".tscn"
	change_2d_scene(next_level_path)
	startGameMusic()

func load_next_level() -> void:
	if(!first_player_ready):
		first_player_ready = true
	else:
		var current_scene_file = path_current_2d_scene
		var next_level_number = current_scene_file.to_int() + 1
		load_level(next_level_number)

func startGameMusic():
	if(!audio_stream_player_2d.playing):
		menu_stream_player_2d_2.playing = false
		audio_stream_player_2d.playing = true
func move_music():
	audio_stream_player_2d.position.y -=1400
	SFX_stream_player.position.y -=1400
	menu_stream_player_2d_2.position.y -=1400
