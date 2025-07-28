extends Camera2D
@export var camera_zoom : Vector2

func _ready() -> void:
	self.make_current()
	zoom = camera_zoom
