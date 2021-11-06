extends KinematicBody2D

export var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	move_and_slide(velocity)

func init(new_velocity):
	velocity = new_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
