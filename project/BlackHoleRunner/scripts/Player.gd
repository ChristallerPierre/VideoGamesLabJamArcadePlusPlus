extends Area2D

var player_speed = 50
var shot_timer
# x to 0, decremented by shot_timer_increment*delta each frame
var default_shot_timer = 1
var shot_timer_increment = 3
export var max_velocity = 100
export var velocity = Vector2()
export (PackedScene) var BulletScene

onready var gunPosition = $GunPosition
onready var spritePosition = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = OS.get_real_window_size() / 2
	shot_timer = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player(delta)
	check_for_input(delta)
	pass

func check_for_input(delta):
	if is_shot_ready(delta):
		var new_velocity = read_input()
		if is_velocity_changed(new_velocity):
			shot_timer = default_shot_timer
			shoot()
	pass

func shoot():
	var bullet = BulletScene.instance()
#	bullet.global_position = gunPosition.global_position
	bullet.global_position = spritePosition.global_position
	bullet.set_direction(velocity)
#	bullet.velocity = velocity
#	bullet.init(velocity)
	add_child(bullet)
#	add_child_below_node(get_tree().get_root().get_node("MainNode"),bullet)
	pass

func is_velocity_changed(new_velocity):
	if new_velocity != Vector2():
		velocity += new_velocity
		if velocity.x > max_velocity:
			velocity.x = max_velocity
		if velocity.y > max_velocity:
			velocity.y = max_velocity
		return true
	return false

func move_player(delta):
	if velocity.length() <= 0:
		pass
	
	position += velocity * delta
	
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	pass

# don't call this until animations are implemented
func animate_sprite():
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
	var new_velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		new_velocity.x += player_speed
	if Input.is_action_pressed("ui_left"):
		new_velocity.x -= player_speed
	if Input.is_action_pressed("ui_down"):
		new_velocity.y += player_speed
	if Input.is_action_pressed("ui_up"):
		new_velocity.y -= player_speed
	return new_velocity
