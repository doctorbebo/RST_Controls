extends Spatial
var camera : Camera = null

func _ready():
	var parent = get_parent()
	if parent is Camera:
		camera = parent
	else:
		print("This Node must be a child of camera.")

func _input(event : InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var ray_origin = get_parent().project_ray_origin(event.position)
			var ray_direction = camera.project_ray_normal(event.position)
			var ray_length = 1000.0  # Adjust the ray length as needed.
			var result = get_world().direct_space_state.intersect_ray(ray_origin, ray_origin + ray_direction * ray_length)

			if result:
				var clicked_object = result.collider
				for i in range(result.collider.get_child_count()):
					var child_node = result.collider.get_child(i)
					if child_node is Clickable:
						child_node.emit_signal("on_clicked", event)
