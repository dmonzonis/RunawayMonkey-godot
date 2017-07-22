extends "entity.gd"

const LIFETIME = 1.5
var lifeCounter

func _ready():
	speed = 500
	lifeCounter = 0
	add_to_group("Entity")
	add_to_group("Projectile")
	get_node("sound").play("woosh")
	
func setVelocity(direction):
	# TODO: make projectile inherit some of the player's speed
	velocity = direction * speed
	
func update(delta):
	lifeCounter += delta
	if lifeCounter >= LIFETIME:
		self.queue_free()
