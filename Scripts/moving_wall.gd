extends CharacterBody2D

const speed= 100.0

var direction = 1

func add_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity()*delta
		
func move_wall():
	velocity.x = speed*direction

func reverse_direction():
	if is_on_wall():
		direction = -direction

func _physics_process(delta: float) -> void:
	add_gravity(delta)
	move_wall()
	move_and_slide()
	reverse_direction()
