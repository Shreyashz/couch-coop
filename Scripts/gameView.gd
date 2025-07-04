extends Node

@onready var players :={
	"1": {
		viewport= $"HBoxContainer/SubViewportContainer/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer/SubViewport/Camera2D",
		player=$HBoxContainer/SubViewportContainer/SubViewport/Cage/p1_player_body,
	},
	"2": {
		viewport= $"HBoxContainer/SubViewportContainer2/SubViewport",
		camera = $"HBoxContainer/SubViewportContainer2/SubViewport/Camera2D",
		player=$HBoxContainer/SubViewportContainer/SubViewport/Cage/p2_player_body,
	}
}

func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)
