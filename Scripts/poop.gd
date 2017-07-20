extends "entity.gd"

const LIFETIME = 1.5
var lifeCounter

func _ready():
	speed = 400
	lifeCounter = 0
	
func setVelocity(direction):
	velocity = direction * speed
	
func update(delta):
	lifeCounter += delta
	if lifeCounter >= LIFETIME:
		self.queue_free()

