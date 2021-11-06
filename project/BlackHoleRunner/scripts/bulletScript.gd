extends KinematicBody2D

export (int) var speed = 5
var direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		move_and_slide(-direction * speed)

func set_direction(new: Vector2):
	direction = new
