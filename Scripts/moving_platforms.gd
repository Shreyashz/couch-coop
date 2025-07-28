extends Path2D

@export var loop=true
@export var speed=2.0
@export var speed_scale = 1.0

@export var path:PathFollow2D
@export var animationplayer:AnimationPlayer

func _read():
	if not loop:
		animationplayer.play("move")
		animationplayer.speed_scale = speed_scale
		set_process(false)
	
func _process(delta: float) -> void:
	path.progress += speed
