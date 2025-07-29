extends RigidBody2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
var limit_height
var timer = 0
var character_timer = 0
var dir = 1
func _physics_process(delta: float) -> void:
	linear_velocity.x = 300 * dir
	ray_cast_2d.global_rotation = 0.0
	ray_cast_2d_2.global_rotation = 0.0
	if(ray_cast_2d.is_colliding() and (ray_cast_2d.get_collider() is TileMapLayer or ray_cast_2d.get_collider() is RigidBody2D)):
		dir = -1
		timer = 0.1
		ray_cast_2d.enabled = false
		ray_cast_2d_2.enabled = false
	if(ray_cast_2d_2.is_colliding() and (ray_cast_2d_2.get_collider() is TileMapLayer or ray_cast_2d_2.get_collider() is RigidBody2D)):
		dir = 1
		timer = 0.1
		ray_cast_2d.enabled = false
		ray_cast_2d_2.enabled = false
	if(ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() is CharacterBody2D):
		character_timer +=delta
		if(character_timer>1):
			character_timer=0
			dir = -1
			timer = 0.1
			ray_cast_2d.enabled = false
			ray_cast_2d_2.enabled = false
	if(ray_cast_2d_2.is_colliding() and ray_cast_2d_2.get_collider() is CharacterBody2D):
		character_timer +=delta
		if(character_timer>1):
			character_timer=0
			dir = 1
			timer = 0.1
			ray_cast_2d.enabled = false
			ray_cast_2d_2.enabled = false
	if(timer > 0):
		timer+=delta
		if(timer >= 1.5):
			timer = 0
			ray_cast_2d.enabled = true
			ray_cast_2d_2.enabled = true
	if(global_position.y >= limit_height):
		queue_free()
