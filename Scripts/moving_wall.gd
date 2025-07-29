extends CharacterBody2D

@export var speed= 100.0
var current_Class:String
var direction = 1
var coll_wall:bool

func add_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity()*delta
		
func move_wall():
	velocity.x = speed*direction

func reverse_direction():
	#for i in get_slide_collision_count():
		#var collider = get_slide_collision(i).get_collider()
		#if collider != null and (collider is StaticBody2D or (collider is CharacterBody2D and (collider.name != "p1_player_body" and collider.name != "p2_player_body"))):
	if is_on_wall():
		direction = -direction
	
func _physics_process(delta: float) -> void:
	add_gravity(delta)
	move_wall()
	move_and_slide()
	reverse_direction()
