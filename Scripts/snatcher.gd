extends "entity.gd"

var playerPos = Vector2(0, 0)

func _ready():
	speed = 150
	add_to_group("Entity")
	add_to_group("Enemy")
	
func update(delta):
	var direction = (playerPos - get_pos()).normalized()
	velocity = direction * speed
		
func getPlayerPosition(position):
	playerPos = position
