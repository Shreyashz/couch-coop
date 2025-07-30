extends Camera2D
@export var camera_zoom : Vector2
var player_count = 0
var is_moving = false
var previous:Vector2
func _ready() -> void:
	self.make_current()
	zoom = camera_zoom
	Global.game_controller.change_guiPos(global_position)
	
func move():
	player_count+=1
	if(player_count == 2):
		player_count=0
		is_moving=true
	
func _process(delta: float) -> void:
	if(get_parent().has_meta("cam_pos")):
		var curr_pos = global_position
		if previous != curr_pos:
			get_parent().set_meta("cam_pos", curr_pos)
			Global.game_controller.change_guiPos(curr_pos)
		previous = curr_pos
	if(is_moving):
		position.y -=1400
		Global.game_controller.move_music()
		is_moving = false
