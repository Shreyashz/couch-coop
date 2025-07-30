extends Camera2D
@export var camera_zoom : Vector2
var player_count = 0
var is_moving = false
func _ready() -> void:
	self.make_current()
	zoom = camera_zoom

func move():
	player_count+=1
	if(player_count == 2):
		player_count=0
		is_moving=true
	
func _process(delta: float) -> void:
	if(is_moving):
		position.y -=1400
		Global.game_controller.move_music()
		is_moving = false
