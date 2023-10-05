extends Spatial  # Use "Spatial" for basic movement or "RigidBody" for physics-based movement.

export var move_speed = 5.0  # Adjust the movement speed as needed.

export (int, 0, 1000) var min_rotation_angle = 10
export (int, 0, 1000) var max_rotation_angle = 90
export (float, 0.0, 1000.0, 0.1) var rotation_speed = 10.0

export (int, 0, 1000) var min_zoom = 10
export (int, 0, 1000) var max_zoom = 90
export (float, 0, 1000, 0.1) var zoom_speed = 10
export (float, 0, 1, 0.1) var zoom_damp = 0.5

onready var camera = $Elevation/Camera
var zoom_direction = 0

func _physics_process(delta):
	_zoom(delta)
	_rotate(delta)
	_move(delta)
	

		
		
func _zoom(delta: float) -> void:
	var new_zoom = clamp(camera.translation.z + zoom_speed * delta * zoom_direction, min_zoom, max_zoom)
	camera.translation.z = new_zoom
	zoom_direction *= zoom_damp
	if abs(zoom_direction) <= 0.0001:
		zoom_direction = 0
	
func _rotate(delta: float) -> void:
	var rotate_vector = 0.0
		
			# Check for input to move left and right.
	if Input.is_action_pressed("rotate_left"):
		rotate_vector += 1
	if Input.is_action_pressed("rotate_right"):
		rotate_vector -= 1
		
	rotate_vector = rotate_vector * delta * (rotation_speed /100)
	rotate(Vector3.UP, rotate_vector)

	
func _move(delta: float) -> void:
	var move_vector = Vector3(0, 0, 0)

	# Check for input to move forward and backward.
	if Input.is_action_pressed("move_forward"):
		move_vector -= transform.basis.z * move_speed
	if Input.is_action_pressed("move_backward"):
		move_vector += transform.basis.z * move_speed

	# Check for input to move left and right.
	if Input.is_action_pressed("move_left"):
		move_vector -= transform.basis.x * move_speed
	if Input.is_action_pressed("move_right"):
		move_vector += transform.basis.x * move_speed
		
	move_vector = move_vector.normalized() * move_speed * delta
	translation += move_vector
	
func _unhandled_input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom_direction = -1
	if event.is_action_pressed("cam_zoom_out"):
		zoom_direction = 1
