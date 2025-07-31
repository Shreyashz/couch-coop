extends Path2D

@export var loop=true
@export var speed=2.0
@export var speed_scale = 1.0
@export var Stopped = false
@export var path:PathFollow2D
@export var animationplayer:AnimationPlayer

var cur_speed
var moving:bool = false

func _ready() -> void:
	cur_speed = speed
	if not loop and not Stopped:
		animationplayer.play("move")
		animationplayer.speed_scale = speed_scale
		set_process(false)
	if Stopped:
		animationplayer.pause()
		animationplayer.speed_scale = speed_scale

func _move() -> void:
	if (!loop):
		animationplayer.play("move")
		cur_speed = speed
	else:
		moving = true
func _stop() -> void:
	if (!loop):
		animationplayer.pause()
		cur_speed = 0.0
	else:
		moving = false

func _process(delta: float) -> void:
	if(!Stopped and loop):
		path.progress += cur_speed
	elif(Stopped and loop and moving):
		path.progress += cur_speed
	else:
		animationplayer.speed_scale = speed_scale
