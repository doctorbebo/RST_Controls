extends MeshInstance

onready var turret = preload("res://Turret/Turret.tscn")
onready var parent = get_parent()

func _on_Clickable_on_clicked(event):
	var t = turret.instance()
	parent.add_child(t)
	t.rotation = rotation
	t.translation = translation
	queue_free()
	
