extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var left_wheel: Node3D
@export var right_wheel: Node3D

const FRICTION = 3.0
const MAX_SPEED = 25.0
const ACCELERATION = 5.0
const STEERING_SENSITIVITY = 0.75

var speed = 0.0

func _ready():
	velocity = Vector3.ZERO

func _physics_process(delta):
	velocity = Vector3.ZERO
	velocity.y = -gravity
#	if !is_on_floor():
#		print("airbourne")
#		return

	if Input.is_action_pressed("forward"):
		speed = lerp(speed, MAX_SPEED, ACCELERATION * delta)
	elif Input.is_action_pressed("backward"):
		speed = lerp(speed, -MAX_SPEED, ACCELERATION * delta)

	speed = lerp(speed, 0.0, FRICTION * delta)
	var steering = Input.get_axis("right", "left")
	steer_wheels(steering * speed * STEERING_SENSITIVITY * delta)
	rotate_y(steering * STEERING_SENSITIVITY * speed * delta)
#	velocity += 
	move_and_slide()

func steer_wheels(angle):
	left_wheel.rotation.y = (angle + deg_to_rad(180.0)) * 5
	right_wheel.rotation.y = angle * 5
