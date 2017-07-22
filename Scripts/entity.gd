extends Area2D

var speed
var velocity = Vector2(0, 0)
enum {ORIENTATION_LEFT, ORIENTATION_RIGHT}
var orientation = ORIENTATION_RIGHT
var health
var maxHealth

func _ready():
	pass

# Look at left or right, depending on direction, which is the x coordinate of the looking direction
func lookAt(direction):
	if ((orientation == ORIENTATION_LEFT and direction > 0) 
	or (orientation == ORIENTATION_RIGHT and direction < 0)):
		get_node("sprite").scale(Vector2(-1, 1))
		orientation = 1 if orientation == 0 else 0  # Switch orientation