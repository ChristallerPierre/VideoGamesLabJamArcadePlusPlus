extends Area2D	

signal game_over


func _process(delta):
	$Sprite.rotation_degrees += delta * 100

func _on_BlackHole_body_entered(body):
	emit_signal("game_over")
	pass # Replace with function body.
