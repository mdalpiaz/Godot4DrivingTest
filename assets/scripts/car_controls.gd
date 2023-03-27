extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const FRICTION = 3.0
const MAX_SPEED = 25.0
const ACCELERATION = 5.0
const STEERING_SENSITIVITY = 1.0

var speed = 0.0

func _physics_process(delta):
	velocity.y += gravity * delta
	if !is_on_floor():
		print("airbourne")
		return
	
	if Input.is_action_pressed("forward"):
		speed = lerp(speed, MAX_SPEED, ACCELERATION * delta)
	elif Input.is_action_pressed("backward"):
		speed = lerp(speed, -MAX_SPEED, ACCELERATION * delta)

	speed = lerp(speed, 0.0, FRICTION * delta)
	var steering = Input.get_axis("right", "left")
	
	velocity = Vector3.FORWARD * speed
	move_and_slide()
	rotation = get_floor_normal()
	rotate_y(steering * speed * STEERING_SENSITIVITY * delta)
