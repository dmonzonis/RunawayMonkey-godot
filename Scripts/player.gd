extends "entity.gd"

var cooldown = 0.30
var shootingSpeed = 500

func _ready():
	speed = 250
	
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