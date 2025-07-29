extends Path2D

@export var loop=true
@export var speed=2.0
@export var speed_scale = 1.0
@export var Stopped = false
@export var path:PathFollow2D
@export var animationplayer:AnimationPlayer

var cur_speed

func _ready() -> void:
	cur_speed = speed
	if not loop:
		print("Lol")
		animationplayer.pause()
		animationplayer.speed_scale = speed_scale
		set_process(false)

func _move() -> void:
	animationplayer.play("move")
	cur_speed = speed
func _stop() -> void:
	animationplayer.pause()
	cur_speed = 0.0

func _process(delta: float) -> void:
	path.progress += cur_speed
