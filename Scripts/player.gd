extends "entity.gd"

var cooldown = 0.30
var shootingSpeed = 500

func _ready():
	speed = 250
	health = 3
	
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

# Look at left or right, depending on direction, which is the x coordinate of the looking direction
func lookAt(direction):
	if ((orientation == ORIENTATION_LEFT and direction > 0) 
	or (orientation == ORIENTATION_RIGHT and direction < 0)):
		get_node("monkey_sprite").scale(Vector2(-1, 1))
		orientation = 1 if orientation == 0 else 0  # Switch orientation
		
func damage(amount):
	health -= amount
	get_node("sound").play("chimp_cry")
	if health <= 0:
		# TODO: die
		pass