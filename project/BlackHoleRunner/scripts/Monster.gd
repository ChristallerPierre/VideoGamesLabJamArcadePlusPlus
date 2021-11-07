extends RigidBody2D

const score_on_monster_kill = 100
export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
onready var main_node = get_node("/root/Main")

func _ready():
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Monster_body_entered(_body):
	print("mob tué")
	main_node.score += score_on_monster_kill
	main_node.draw_score()
	destroy()

func destroy():
	self.remove_and_skip()
	hide()
