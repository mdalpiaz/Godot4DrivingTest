extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_vector: Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

@export var left_wheel: Node3D
@export var right_wheel: Node3D

const FRICTION = 20.0
const MAX_SPEED = 25.0
const ACCELERATION = 50.0
const STEERING_SENSITIVITY = 4.0

var speed = 0.0
var steering = 0.0

func _process(_delta):
	_angle_wheels(steering)

func _physics_process(delta):
	velocity += gravity_vector * gravity * delta
	if !is_on_floor():
		steering = 0.0
		move_and_slide()
		return

	print("speed: ", velocity.length_squared())
	velocity += _invert_vector(velocity).normalized() * FRICTION * delta
	if Input.get_action_strength("forward"):
		velocity += -global_transform.basis.z * ACCELERATION * delta
	elif Input.get_action_strength("backward"):
		velocity += global_transform.basis.z * ACCELERATION * delta
	velocity = velocity.limit_length(20)

	steering = Input.get_axis("right", "left")
	print(get_floor_normal())
	var steer_angle = steering * STEERING_SENSITIVITY * delta
	rotate_y(steer_angle)
	velocity = velocity.rotated(Vector3.UP, steer_angle)
	move_and_slide()

func _angle_wheels(angle):
	angle *= 0.75
	left_wheel.rotation.y = (angle + deg_to_rad(180.0))
	right_wheel.rotation.y = angle

func _invert_vector(vec: Vector3) -> Vector3:
	return Vector3(-vec.x, -vec.y, -vec.z)
