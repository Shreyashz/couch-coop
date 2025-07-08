extends Node
@onready var cage: Node2D = $HBoxContainer/SubViewportContainer/SubViewport/Cage
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
	get_node("HBoxContainer/SubViewportContainer/SubViewport/Cage").get_node("water_body").camera1 = get_node("HBoxContainer/SubViewportContainer/SubViewport/Camera2D")
	get_node("HBoxContainer/SubViewportContainer/SubViewport/Cage").get_node("water_body").camera2 = get_node("HBoxContainer/SubViewportContainer2/SubViewport/Camera2D")
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	for node in players.values():
		node.camera.target = node.player
