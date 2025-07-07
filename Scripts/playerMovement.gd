extends CharacterBody2D
var swimming = false
@export var curr_scene:Node2D = null
@export var controls:Resource = null
@export var spriteControl:Sprite2D = null
var pa_abajo = false

const SPEED = 300.0
var JUMP_VELOCITY = -400.0
func ready() -> void:
	if has_meta("player_index"):
		match curr_scene.get_meta("player_index"):
			0:
				JUMP_VELOCITY -= 100
			1:
				JUMP_VELOCITY = JUMP_VELOCITY + 100
func apply_gravity(delta): 
	# Add the gravity.
	if not is_on_floor() && !swimming:
		velocity += get_gravity() * delta
	if(swimming && velocity.y < -2):
		velocity += get_gravity() * delta
	if(swimming && velocity.y > -2):
		velocity += -get_gravity() * delta

func _process(delta: float) -> void:
	if(velocity.x>0):
		# walking Right
		spriteControl.flip_h = false
	elif(velocity.x<0):
		# walking left
		spriteControl.flip_h = true
	else:
		# IDeal
		pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	# Handle jump.
	if (Input.is_action_just_pressed(controls.jump) or Input.is_action_just_pressed(controls.move_up)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed(controls.jump) or Input.is_action_just_pressed(controls.move_up)) and !is_on_floor() and swimming:
		velocity.y = JUMP_VELOCITY
		
	if(Input.is_action_just_pressed(controls.move_down) and swimming):
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.move_left, controls.move_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
