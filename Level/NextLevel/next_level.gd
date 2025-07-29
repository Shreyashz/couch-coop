extends Area2D
@export var playerNo:Resource

func _on_body_entered(body):
	if body.is_in_group("Player") and body.has_meta("playerIndex") and body.get_meta("playerIndex") == playerNo.player_index:
		Global.game_controller.load_next_level()
		queue_free()
		
