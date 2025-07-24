extends StaticBody2D
var falling = false
var secs = 0
var pos

func _ready() -> void:
	pos = position

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.get_parent().name)
	if(area.get_parent().name == "p1_player_body" or area.get_parent().name == "p2_player_body"):
		falling = true
		
func _physics_process(delta: float) -> void:
	if(falling):
		secs +=delta
		if(secs>=1):
			self.position.y +=350*delta
		if(secs >=5):
			self.position = pos
			falling = false
			secs = 0
