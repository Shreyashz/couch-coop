extends CharacterBody2D
#im going to start commenting things bc its getting VERY COMPLICATED
var swimming = false
var can_roll = false
var active_roll = false
var pos=0
var defaultAnimationScale:float = 1.0

@export var WalkScaleAnimation:float = 1.0
@export var curr_scene:Node2D = null
@export var controls:Resource = null
@export var spriteControl:Sprite2D = null
@export var animationTree:AnimationTree = null

var pa_abajo = false
#little variables we need to check things, mostly flags
const SPEED = 400.0
var JUMP_VELOCITY = -500.0
#speed and jump thingys
func ready() -> void:
	print("got it")
	if has_meta("player_index"):# THIS THING DOESNT WORK FOR SOME REASON
		match get_meta("player_index"):
			0:
				JUMP_VELOCITY += 100
			1:
				JUMP_VELOCITY  -= 100
				can_roll=true


func apply_gravity(delta): 
	# Add the gravity.
	if not is_on_floor() && !swimming:
		velocity += get_gravity() * delta
	if(swimming && velocity.y < -2):
		velocity += get_gravity() * delta
	if(swimming && velocity.y > -2):
		velocity += -get_gravity() * delta

func _process(delta: float) -> void:
	if(can_roll):#if it can roll, then you just store the value of the position (if i dont do this it gets fucky)
		pos = get_parent().get_node("Ball_collision").global_position
	if(can_roll && !active_roll): #if it can roll but isnt rolling then just grab the ball and take it with you
		get_parent().get_node("Ball_collision").global_position = global_position
	if(can_roll && active_roll): #if it can roll and its rolling you teleport to the ball
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
	if (Input.is_action_just_pressed(controls.move_up)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if( Input.is_action_just_released(controls.move_up)) and !is_on_floor():
		velocity.y = 0
	if (Input.is_action_just_pressed(controls.move_up)) and !is_on_floor() and swimming:
		velocity.y = JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.move_down) and swimming):
		velocity.y = -JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.jump) && can_roll): #you activate the roll mode with the interact button
		active_roll = !active_roll
		if(!active_roll):
			rotation=0.0#if you stop rolling, you get rotated to your initial pos
			get_parent().get_node("Ball_collision").rotation=0.0
		get_node("playerBody_Collision").disabled = !get_node("playerBody_Collision").disabled
		get_parent().get_node("Ball_collision").get_child(0).disabled = !get_parent().get_node("Ball_collision").get_child(0).disabled

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.move_left, controls.move_right)
	if(!active_roll):#if it isnt rolling, well you walk
		if direction:
			animationTree.set("parameters/Transition/transition_request", "Walk")
			animationTree.set("parameters/TimeScale/scale", WalkScaleAnimation)
			velocity.x = direction * SPEED
		else:
			animationTree.set("parameters/Transition/transition_request", "Idle")
			animationTree.set("parameters/TimeScale/scale", defaultAnimationScale)
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else: #if it isnt, then you check for some raycast so it doesnt move while on the air and just apply force to the ball
		get_parent().get_node("Ball_collision").get_node("floor_raycast").global_rotation =0.0
		get_parent().get_node("Ball_collision").get_node("floor_raycast2").global_rotation =0.0
		get_parent().get_node("Ball_collision").get_node("floor_raycast3").global_rotation =0.0
		if(get_parent().get_node("Ball_collision").get_node("floor_raycast").is_colliding() || get_parent().get_node("Ball_collision").get_node("floor_raycast2").is_colliding() || get_parent().get_node("Ball_collision").get_node("floor_raycast3").is_colliding()):
			get_parent().get_node("Ball_collision").apply_force(Vector2(direction * 1250, 0))
			self.rotation = get_parent().get_node("Ball_collision").rotation #penguin rolls yeyeaa
		
	move_and_slide()


func _on_j_area_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "p2_player_body"):
		velocity.y = JUMP_VELOCITY * 1.5

func _on_stopping_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "p1_player_body"):
		var direction = (global_position - get_parent().get_node("Ball_collision").global_position).normalized()
		get_parent().get_node("Ball_collision").apply_force(-direction * 10000)
