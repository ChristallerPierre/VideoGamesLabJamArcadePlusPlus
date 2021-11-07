extends Control

func _ready():
	pass # Replace with function body.
func _process(delta):
	$Sprite2.rotation_degrees += delta*20

func _on_Start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
