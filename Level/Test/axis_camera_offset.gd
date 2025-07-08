extends Camera2D
@export var target:CharacterBody2D


func _process(delta: float) -> void:
	if(target):
		global_position.x = target.global_position.x
