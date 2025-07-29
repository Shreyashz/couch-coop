extends Node2D
var timer = 0
const SNOWBALL = preload("res://Prefab/Snowball.tscn")
@export var Limit_height : int
func _ready() -> void:
	var new_ball = SNOWBALL.instantiate()
	add_child(new_ball)
	new_ball.limit_height = Limit_height
	new_ball.global_position = global_position

func _process(delta: float) -> void:
	timer+=delta
	if(timer >4):
		timer = 0
		var new_ball = SNOWBALL.instantiate()
		add_child(new_ball)
		new_ball.limit_height = Limit_height
		new_ball.global_position = global_position
