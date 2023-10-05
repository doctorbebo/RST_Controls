extends Spatial

export var speed = 10

func _on_Timer_timeout():
	queue_free()
	
func _physics_process(delta):
	var velocity = Vector3.FORWARD * speed * delta
	translate(velocity)


func _on_Area_body_entered(body):
	print("Hit " + body.name)
	queue_free()
