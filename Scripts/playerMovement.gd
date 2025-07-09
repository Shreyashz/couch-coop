extends CharacterBody2D
var swimming = false
var can_roll = false
var active_roll = false
var pos=0
@export var curr_scene:Node2D = null
@export var controls:Resource = null
@export var spriteControl:Sprite2D = null
var pa_abajo = false

const SPEED = 400.0
var JUMP_VELOCITY = -500.0
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
	print(rotation)
	if(name == "p2_player_body"):
		can_roll=true
	if(can_roll):
		pos = get_parent().get_node("Ball_collision").global_position
	if(can_roll && !active_roll):
		get_parent().get_node("Ball_collision").global_position = global_position
	if(can_roll && active_roll):
		global_position=get_parent().get_node("Ball_collision").global_position
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
	if (Input.is_action_just_pressed(controls.jump) or Input.is_action_just_pressed(controls.move_up)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed(controls.jump) or Input.is_action_just_pressed(controls.move_up)) and !is_on_floor() and swimming:
		velocity.y = JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.move_down) and swimming):
		velocity.y = -JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.interact) && can_roll):
		active_roll = !active_roll
		if(!active_roll):
			rotation=0.0
			get_parent().get_node("Ball_collision").rotation=0.0
		get_node("playerBody_Collision").disabled = !get_node("playerBody_Collision").disabled
		get_parent().get_node("Ball_collision").get_child(0).disabled = !get_parent().get_node("Ball_collision").get_child(0).disabled

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.move_left, controls.move_right)
	if(!active_roll):
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		get_parent().get_node("Ball_collision").get_node("floor_raycast").global_rotation =0.0
		if(get_parent().get_node("Ball_collision").get_node("floor_raycast").is_colliding()):
			get_parent().get_node("Ball_collision").apply_force(Vector2(direction * 2000, 0))
			self.rotation = get_parent().get_node("Ball_collision").rotation
		

	move_and_slide()
