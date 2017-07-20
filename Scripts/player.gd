extends Node2D

var speed = 250
var velocity = Vector2(0, 0)
var cooldown = 0.30
var shootingSpeed = 500
enum {ORIENTATION_LEFT, ORIENTATION_RIGHT}
var orientation = ORIENTATION_RIGHT

func _ready():
	pass
	
func modifyVelocity(delta):
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("move_up")):
		velocity.y -= speed
	if (Input.is_action_pressed("move_down")):
		velocity.y += speed
	if (Input.is_action_pressed("move_left")):
		velocity.x -= speed
	if (Input.is_action_pressed("move_right")):
		velocity.x += speed

func update(delta):
	modifyVelocity(delta)