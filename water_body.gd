extends Node2D
var springs = []
var spacing = 0
var left = []
var right= []
var k = 0.015
@onready var water_colision: CollisionPolygon2D = $Area2D/water_colision
var dampening = 0.03
@onready var water: Polygon2D = $water
@onready var spring_Scene = preload("res://Level/water_spring.tscn")
@export var spring_number:int
var spread = 0.0050
func _ready() -> void:
	for i in range(spring_number):
		var child = spring_Scene.instantiate()
		child.position = Vector2(spacing, 0)
		self.add_child(child)
		spacing += 40
	for i in get_children():
		if(i != water && i!=water_colision && !i is Area2D):
			springs.append(i)
			i.initialize()
	for i in range(springs.size()):
		left.append(0)
		right.append(0)
	
	

func _physics_process(delta: float) -> void:
	for i in springs:
		i.water_update(k,dampening)
	
	for i in range(springs.size()):
		if(i > 1):
			left[i] = spread * (springs[i].height - springs[i-1].height)
			springs[i-1].velocity += left[i]
		if(i < springs.size()-1):
			left[i] = spread * (springs[i].height - springs[i+1].height)
			springs[i+1].velocity += left[i]
	draw_water()
func splash(i, speed):
	springs[i].velocity +=speed
	
	
func draw_water():
	var points = []
	for i in range(springs.size()):
		points.append(springs[i].position)

	var water_points = []

	for p in points:
		water_points.append(p)

	for i in range(points.size() - 1, -1, -1):
		var p = points[i]
		water_points.append(Vector2(p.x, p.y + 600))
	water_colision.polygon = water_points

	water_points = PackedVector2Array(water_points)
	water.polygon = water_points

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is CharacterBody2D):
		area.get_parent().swimming = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if(area.get_parent() is CharacterBody2D):
		area.get_parent().swimming = false
