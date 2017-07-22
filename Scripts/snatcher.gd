extends "entity.gd"

var playerPos = Vector2(0, 0)

func _ready():
	speed = 150
	maxHealth = 3
	health = maxHealth
	add_to_group("Entity")
	add_to_group("Enemy")
	
func update(delta):
	var direction = (playerPos - get_pos()).normalized()
	velocity = direction * speed
		
func getPlayerPosition(position):
	playerPos = position

func damage(amount):
	health -= amount
	if health <= 0:
		queue_free()