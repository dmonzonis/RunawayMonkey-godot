extends "entity.gd"

const LIFETIME = 1.5
var lifeCounter

func _ready():
	speed = 400
	lifeCounter = 0
	add_to_group("Entity")
	add_to_group("Projectile")
	
func setVelocity(direction):
	velocity = direction * speed
	
func update(delta):
	lifeCounter += delta
	if lifeCounter >= LIFETIME:
		self.queue_free()
