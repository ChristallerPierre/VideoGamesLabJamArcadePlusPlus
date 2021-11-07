extends Node

const base_score = "Score : "
const text_r_to_reload = "\nAppuyez sur R pour recommencer une partie."
const reload_input = "reload"
export (PackedScene) var Mob
export var score = 0
var game_over

func _ready():
	new_game()
	game_over = false

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	game_over = true
	draw_game_over()
	$Score.text = ""
	$Player.hide()

func _input(event):
	if event.is_action_pressed(reload_input) && game_over:
		print("reloading game")
		get_tree().reload_current_scene()

func new_game():
	randomize()
	var window_dimensions = OS.get_real_window_size()
	$Score.rect_position.x = window_dimensions.x / 2 - 50
	$Score.rect_position.y = 50
	score = 0
	$StartTimer.start()
	$GameOverLabel.text = ""
	$GameOverSprite.hide()
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	draw_score()
	
func _on_MobTimer_timeout():
	# reposition the spawner to the window
	$MobPath/MobSpawnLocation.position = OS.get_real_window_size()
	
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = - $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

func draw_game_over():
	var text = base_score + str(score) + text_r_to_reload
	$GameOverLabel.text = text
	$GameOverSprite.visible = true

func draw_score():
	var text = base_score + str(score)
	$Score.text = text
	return text

func _on_RigidBody2D_game_over():
	print("game over. score : " + draw_score())
	game_over()
