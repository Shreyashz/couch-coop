extends Node2D
var velocity = 0
var force = 0
var height = position.y
var target_height = position.y

func initialize():
	height = position.y
	target_height = position.y
	velocity=0
func water_update(k,d):
	height=position.y
	
	var x = height- target_height
	var loss = -d * velocity
	
	force = - k * x + loss
	
	velocity+=force
	position.y+=velocity
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is CharacterBody2D):
		if(self in self.get_parent().springs):
			get_parent().splash(get_parent().springs.find(self), 4)
