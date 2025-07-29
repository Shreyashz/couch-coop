extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func toggle():
	call_deferred("_do_toggle")

func _do_toggle():
	var was_disabled = collision_shape_2d.disabled
	collision_shape_2d.disabled = !was_disabled
	match modulate.a:
		0.5:
			modulate.a = 1
		1:
			modulate.a = 0.5
	print("Colisión ahora está: ", collision_shape_2d.disabled)
