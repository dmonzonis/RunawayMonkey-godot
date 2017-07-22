extends "entity.gd"

const LIFETIME = 1.5
var lifeCounter
var damage = 1

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

func _on_poop_area_enter(area):
	if area.is_in_group("Enemy"):
		area.damage(damage)
		damage = 0
		queue_free()
