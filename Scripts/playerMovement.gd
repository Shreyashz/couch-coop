extends CharacterBody2D
#im going to start commenting things bc its getting VERY COMPLICATED
var swimming = false
var can_roll = false
var active_roll = false
var stamina = 150
var pos=0
@onready var platform_raycast: RayCast2D = $Platform_raycast
var defaultAnimationScale:float = 1.0
var pending_unroll:bool = false

@export var WalkScaleAnimation:float = 1.0
@export var curr_scene:Node2D = null
@export var controls:Resource = null
@export var spriteControl:Sprite2D = null
@export var animationTree:AnimationTree = null

var waiting_for_ground:bool = false
var pa_abajo = false
#little variables we need to check things, mostly flags
const SPEED = 400.0
var JUMP_VELOCITY = -600.0
#speed and jump thingys
func _ready() -> void:
	if has_meta("playerIndex"):# THIS THING DOESNT WORK FOR SOME REASON
		match get_meta("playerIndex"):
			0:
				pass
			1:
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
		get_parent().get_node("Ball_collision").linear_velocity = velocity
	if(can_roll && active_roll): #if it can roll and its rolling you teleport to the ball
		global_position=get_parent().get_node("Ball_collision").global_position
		velocity = get_parent().get_node("Ball_collision").linear_velocity
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
	var on_floor = is_on_floor()
	if(pending_unroll and on_floor):
		#print("Lol")
		_complete_unroll()
	if (Input.is_action_just_pressed(controls.move_up)) and on_floor:
		Global.game_controller.play_sfx("jump")
		velocity.y = JUMP_VELOCITY
	if( Input.is_action_just_released(controls.move_up)) and !on_floor and velocity.y < 0:
		velocity.y = 0
	if (Input.is_action_just_pressed(controls.move_up)) and !on_floor and swimming:
		velocity.y = JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.move_down) and swimming):
		velocity.y = -JUMP_VELOCITY
	if(Input.is_action_just_pressed(controls.jump) && can_roll): #you activate the roll mode with the interact button
		_unroll_now()
		Global.game_controller.play_sfx("Roll")
		#Code to fix snapping issue on ball
		#if(!active_roll):
			#_unroll_now()
		#elif(active_roll and is_on_floor()):
			#_unroll_now()
		#else:
			#pending_unroll = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(controls.move_left, controls.move_right)
	if(!active_roll):#if it isnt rolling, well you walk
		if direction:
			animationTree.set("parameters/Transition/transition_request", "Walk")
			animationTree.set("parameters/TimeScale/scale", WalkScaleAnimation)
			velocity.x = direction * SPEED
			if(Input.is_action_pressed(controls.interact) && !can_roll && stamina >= 0):
				velocity.x += 300 * direction
				stamina -= 10
			else:
				if(stamina < 150):
					stamina += 5
		else:
			animationTree.set("parameters/Transition/transition_request", "Idle")
			animationTree.set("parameters/TimeScale/scale", defaultAnimationScale)
			var platform_velocity
			if(platform_raycast.is_colliding() and !platform_raycast.get_collider() is TileMapLayer and !platform_raycast.get_collider() is RigidBody2D and !platform_raycast.get_collider() is StaticBody2D):
				platform_velocity = platform_raycast.get_collider().velocity
			else:
				platform_velocity = Vector2(0,0)
			if(platform_velocity != Vector2(0,0)):
				velocity.y = move_toward(velocity.y, 0, SPEED + platform_velocity.y)
			velocity.x = move_toward(velocity.x, 0, SPEED + platform_velocity.x)
	else: #if it isnt, then you check for some raycast so it doesnt move while on the air and just apply force to the ball
		get_parent().get_node("Ball_collision").get_node("floor_raycast").global_rotation =0.0
		get_parent().get_node("Ball_collision").get_node("floor_raycast2").global_rotation =0.0
		get_parent().get_node("Ball_collision").get_node("floor_raycast3").global_rotation =0.0
		if(get_parent().get_node("Ball_collision").get_node("floor_raycast").is_colliding() || get_parent().get_node("Ball_collision").get_node("floor_raycast2").is_colliding() || get_parent().get_node("Ball_collision").get_node("floor_raycast3").is_colliding()):
			get_parent().get_node("Ball_collision").apply_force(Vector2(direction * 1250, 0))
			self.rotation = get_parent().get_node("Ball_collision").rotation #penguin rolls yeyeaa
		
	move_and_slide()

func _unroll_now():
	rotation=0.0#if you stop rolling, you get rotated to your initial pos
	get_parent().get_node("Ball_collision").rotation=0.0
	get_node("playerBody_Collision").disabled = !get_node("playerBody_Collision").disabled
	get_parent().get_node("Ball_collision").get_child(0).disabled = !get_parent().get_node("Ball_collision").get_child(0).disabled
	active_roll = !active_roll

func _complete_unroll():
	if(!active_roll):
		Global.game_controller.play_sfx("Unroll")
		_unroll_now()

func _on_j_area_area_entered(area: Area2D) -> void:
	var parent= area.get_parent()
	if parent.name == "p2_player_body":
		Global.game_controller.play_sfx("jump")
		velocity.y = -900

func _on_stopping_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "p1_player_body"):
		var direction = (global_position - get_parent().get_node("Ball_collision").global_position).normalized()
		get_parent().get_node("Ball_collision").apply_force(-direction * 10000)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	Global.game_controller.curr_SC_Cam.move()
