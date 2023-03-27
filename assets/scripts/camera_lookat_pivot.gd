extends Node3D

var _previous_rotation: float = 0

func _process(delta):
	var parent = get_parent()
	var diff = _previous_rotation - parent.rotation.y
	rotation.y = lerp_angle(rotation.y + diff, 0, 10 * delta)
	global_rotation.x = 0
	global_rotation.z = 0
	_previous_rotation = parent.rotation.y
