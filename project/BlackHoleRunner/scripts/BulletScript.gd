extends KinematicBody2D

# until we find how to not duplicate code ...
const right = "right"
const left = "left"
const up = "up"
const down = "down"
export (int) var speed = 10
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	if velocity != Vector2.ZERO:
		move_and_collide(velocity)

func set_direction(direction):
	var direction_x = 0
	var direction_y = 0
	if direction == right:
		direction_x = 1
	elif direction == left:
		direction_x = -1
	elif direction == up:
		direction_y = 1
	elif direction == down:
		direction_y = -1
	velocity = Vector2(direction_x, direction_y) * speed
	if direction == up || direction == down:
		$CollisionShape2D.rotation_degrees = 90
