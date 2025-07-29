extends Sprite2D

@export var platform : Path2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		region_rect = Rect2(840, 483, 50, 29)
		platform.Stopped = !platform.Stopped

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is CharacterBody2D):
		region_rect = Rect2(775, 483, 50, 29)
		platform.Stopped = !platform.Stopped
