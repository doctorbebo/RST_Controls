extends Spatial

var targets = []
onready var barrel = $Gunner/Barrel
onready var gunner = $Gunner
onready var bullet_tran : Spatial = $"Gunner/Barrel/Bullet Pos"
onready var bullet = preload("res://Turret/Bullet.tscn")

func _on_Area_body_entered(body : Node):
	targets.append(body)


func _on_Area_body_exited(body : Node):
	targets.erase(body)


func _physics_process(_delta):
	if targets.size():
		var target : Node = targets[0]
		gunner.look_at(target.global_translation, Vector3.UP)
		gunner.rotation.x = 0
		gunner.rotation.z = 0
		
		barrel.look_at(target.global_translation, Vector3.UP)
		bullet_tran.look_at(target.global_translation, Vector3.UP)
		barrel.rotation.z = 0
		barrel.rotation.y = 0

func _on_Timer_timeout():
	if targets.size():
		_fire()
		
func _fire():
	var b = bullet.instance()

	get_tree().get_root().add_child(b)
	b.global_transform.origin = bullet_tran.global_transform.origin
	b.global_rotation = bullet_tran.global_rotation
