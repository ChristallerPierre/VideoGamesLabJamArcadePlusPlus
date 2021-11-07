extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var scrolling_speed = 0 #-500.0
var windowSizeX = OS.get_real_window_size().x;
var windowSizeY = OS.get_real_window_size().y;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	self.position.x = 10
	scroll_offset.y += scrolling_speed * delta
	pass
