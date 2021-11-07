extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

func _ready():
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Monster_body_entered(_body):
	print("mob tué")
	self.remove_and_skip()
	hide()
	pass # Replace with function body.
