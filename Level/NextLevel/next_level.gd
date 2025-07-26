extends Area2D

func _on_body_entered(body):
	print("Lol")
	if body.is_in_group("Player"):
		Global.game_controller.load_next_level()
