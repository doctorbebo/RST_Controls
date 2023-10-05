extends Spatial

export (float, 0.0, 1000.0, 5) var rotation_speed = 10.0
export (float, 0.0, 100, 5) var flip_speed = 10.0
var fliped = false
var lerping = false
var weight = 0

var rot_0 : Quat = Quat(Vector3(0,0,0))
var rot_180 : Quat = Quat(Vector3(0,0,180))


func _process(delta):
	_rotate(delta)
	
	if Input.is_action_just_pressed("flip") and not lerping:
		_flip(delta)
		
	if lerping:
		_flip(delta)

func _rotate(delta: float) -> void:
	var rotate_vector = 0.0
		
			# Check for input to move left and right.
	if Input.is_action_pressed("rotate_left"):
		rotate_vector += 1
	if Input.is_action_pressed("rotate_right"):
		rotate_vector -= 1
		
	rotate_vector = rotate_vector * delta * (rotation_speed /100)
	
	if fliped: 
		rotate_vector = -rotate_vector
		
	rotate(Vector3.UP, rotate_vector)

var elapsed = 0.0

func _flip(delta: float) -> void:	
	var min_angle = deg2rad(0.0)
	var max_angle = deg2rad(180.0)
	
	if fliped:
		min_angle = deg2rad(180.0)
		max_angle = deg2rad(0.0)
	
	rotation.z = lerp_angle(min_angle, max_angle, elapsed)
	elapsed += flip_speed / 50 * delta
	
	if elapsed > 1:
		rotation.z = max_angle
		lerping = false
		fliped = not fliped
		elapsed = 0
	else:
		lerping = true
