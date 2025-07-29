extends Sprite2D

@export var switchable_Wall : StaticBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		region_rect = Rect2(968, 483, 50, 29)
		switchable_Wall.toggle()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is CharacterBody2D):
		region_rect = Rect2(903, 483, 50, 29)
		switchable_Wall.toggle()
