extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var Start_Disabled = false

func _ready() -> void:
	if(Start_Disabled):
		toggle()

func toggle():
	call_deferred("_do_toggle")

func _do_toggle():
	var was_disabled = collision_shape_2d.disabled
	collision_shape_2d.disabled = !was_disabled
	if(modulate.a == 1):
		modulate.a = 0.5
	else:
		modulate.a = 1
