extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity_vector: Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity_vector")

@export var left_wheel: Node3D
@export var right_wheel: Node3D
@export var car_model: Node3D

const FRICTION = 20.0
const MAX_SPEED = 25.0
const ACCELERATION = 50.0
const STEERING_SENSITIVITY = 4.0
const CAR_TO_FLOOR_ROTATION_SPEED = 4.0

var steering = 0.0

func _process(_delta):
	_angle_wheels(steering)

func _physics_process(delta):
	velocity += gravity_vector * gravity * delta
	steering = Input.get_axis("right", "left")
	var forward = Input.get_action_strength("forward")
	var backward = Input.get_action_strength("backward")
	if !is_on_floor():
		move_and_slide()
		return

	velocity += _invert_vector(velocity).normalized() * FRICTION * delta
	
	velocity += -global_transform.basis.z * ACCELERATION * forward * delta
	velocity += global_transform.basis.z * ACCELERATION * backward * delta
	velocity = velocity.limit_length(20)

	print(car_model.rotation)
	print(get_slide_collision(0).get)
	var steer_angle = steering * STEERING_SENSITIVITY * delta
	rotate_y(steer_angle)
	velocity = velocity.rotated(Vector3.UP, steer_angle)
	move_and_slide()

func _align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func _angle_wheels(angle):
	angle *= 0.75
	left_wheel.rotation.y = (angle + deg_to_rad(180.0))
	right_wheel.rotation.y = angle

func _invert_vector(vec: Vector3) -> Vector3:
	return Vector3(-vec.x, -vec.y, -vec.z)
