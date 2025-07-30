extends AnimatedSprite2D
var body2D : CharacterBody2D
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		body2D = body
		play("Activate")

func _process(delta: float) -> void:
	if(animation == "Activate" && frame == 3):
		body2D.velocity.y = -1200
