extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit_tut"):
		queue_free()
