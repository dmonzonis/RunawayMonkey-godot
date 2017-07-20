extends Node2D

var speed = 400
var velocity
const LIFETIME = 1.5
var lifeCounter

func _ready():
	lifeCounter = 0
	
func setVelocity(direction):
	velocity = direction * speed
	
func update(delta):
	lifeCounter += delta
	if lifeCounter >= LIFETIME:
		self.queue_free()

