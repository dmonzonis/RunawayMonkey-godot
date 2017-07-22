extends Node2D

const player = preload("res://Prefabs/player.tscn")
const poop = preload("res://Prefabs/poop.tscn")
const snatcher = preload("res://Prefabs/snatcher.tscn")

var playerNode
var counter = 0
var mousePos = Vector2(-100, -100)

# DEBUG variables
var debugCounter = 0
var fps = 0

func _ready():
	playerNode = get_node("player")
	playerNode.add_to_group("Entity")
	set_process(true)

func _process(delta):
	updateAI()
	updateEntities(delta)
	updateCrosshair()
	handleShooting(delta)
	handleCollisions()
	# DEBUG: show fps
	debugCounter += 1
	fps += 1 / delta
	if debugCounter > 15:
		fps /= debugCounter
		get_node("debugLabel").set_text("FPS: " + str(fps))
		debugCounter = 0
		fps = 0

func handleCollisions():
	if playerNode.is_colliding():
		var other = playerNode.get_collider()
		if other.is_in_group("Enemy"):
			playerNode.damage(1)
			other.queue_free()
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.is_colliding():
			var other = enemy.get_collider()
			if other == playerNode:
				playerNode.damage(1)
				enemy.queue_free()
	for projectile in get_tree().get_nodes_in_group("Projectile"):
		if projectile.is_colliding():
			# If poop touches enemy, damage it
			var other = projectile.get_collider()
			if other.is_in_group("Enemy"):
				other.queue_free()
				projectile.queue_free()

# Handle entity updating and movement
func updateEntities(delta):
	for entity in get_tree().get_nodes_in_group("Entity"):
		entity.update(delta)
		entity.move(entity.velocity * delta)
		
# Set crosshair to mouse's position and make player look at crosshair's direction
func updateCrosshair():
	var crosshair = get_node("crosshair")
	mousePos = get_global_mouse_pos()
	crosshair.set_pos(mousePos)
	var lookDirection = crosshair.get_pos().x - playerNode.get_pos().x
	# Flip player if crosshair is behind
	playerNode.call("lookAt", lookDirection)

# If shooting is not on cooldown, shoot a projectile in the crosshair's direction
func handleShooting(delta):
	var playerPos = playerNode.get_pos()
	if counter < playerNode.cooldown:
		counter += delta
	elif Input.is_action_pressed("fire"):
		var shootDirection = (mousePos - playerPos).normalized()
		var poopNode = poop.instance()
		add_child(poopNode)
		var offset = shootDirection.normalized() * 35
		poopNode.set_pos(playerPos + offset)
		poopNode.call("setVelocity", shootDirection)
		counter = 0
		
func updateAI():
	# Inform enemies of player's current position
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.getPlayerPosition(playerNode.get_pos())