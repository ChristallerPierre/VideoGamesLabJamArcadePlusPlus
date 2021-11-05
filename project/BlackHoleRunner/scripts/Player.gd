extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#Vector2 vector = null
export var speed = 400
var player_speed = 0.5
var shot_timer
# shoot every x ms
var default_shot_timer = 500
var shot_timer_increment = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = OS.get_real_window_size() / 2
	shot_timer = default_shot_timer
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_shot_ready(delta):
		var velocity = read_input()
		if velocity.length() > 0:
			shot_timer = default_shot_timer
			
			velocity = velocity.normalized() * speed
			position += velocity * delta
			
			var screen_size = get_viewport_rect().size
			position.x = clamp(position.x, 0, screen_size.x)
			position.y = clamp(position.y, 0, screen_size.y)
	pass

# don't call this until animations are implemented
func animate_sprite(velocity):
	if velocity.length > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func is_shot_ready(delta):
	if shot_timer >= 0:
		shot_timer -= delta * shot_timer_increment
		return false
	return true

func read_input():
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += player_speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= player_speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += player_speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= player_speed
	return velocity