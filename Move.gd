extends MeshInstance

func _input(event):
	
	if event is InputEventKey:
		print("Moving")
		if event.pressed and event.scancode == KEY_RIGHT:
			translate(Vector3.FORWARD * 1)
		if event.pressed and event.scancode == KEY_LEFT:
			translate(Vector3.BACK * 1)
		if event.pressed and event.scancode == KEY_UP:
			translate(Vector3.UP * 1)
		if event.pressed and event.scancode == KEY_DOWN:
			translate(Vector3.DOWN * 1)
