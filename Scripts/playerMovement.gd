extends CharacterBody2D

@export var curr_scene:Node2D
@export var controls:Resource = null

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func ready() -> void:
	print(curr_scene.name)
	if curr_scene.has_meta("Level_Type"):
		match curr_scene.get_meta("Level_Type"):
			"TopDown":
				print("A top down Scene")
			"Platformer":
				print("A platformer Scene")
func apply_gravity(delta): 
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	# Handle jump.
	if Input.is_action_just_pressed(controls.jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.move_left, controls.move_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
