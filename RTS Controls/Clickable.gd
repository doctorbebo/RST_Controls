extends CollisionShape  # Use the appropriate base type for your node.
class_name Clickable

signal on_clicked(event)


func _printMsg(event: InputEvent):
	print("Clicked!")


func _ready():
	# Syntax for connecting to a signal
	self.connect("on_clicked", self, "_printMsg")
