extends Node2D

const player = preload("res://Prefabs/player.tscn")
const poop = preload("res://Prefabs/poop.tscn")

var playerNode
var counter = 0
var mousePos = Vector2(-100, -100)

func _ready():
	playerNode = get_node("player")
	set_process(true)

func _process(delta):
	# Move player
	var playerPos = playerNode.get_pos()
	playerNode.call("update", delta)
	var newPlayerPos = playerPos + playerNode.velocity * delta
	playerNode.set_pos(newPlayerPos)
	
	# Move projectiles
	for projectile in get_tree().get_nodes_in_group("Projectiles"):
		projectile.update(delta)
		projectile.set_pos(projectile.get_pos() + projectile.velocity * delta)
	
	# Position crosshair and make player look at it
	var crosshair = get_node("crosshair")
	mousePos = get_global_mouse_pos()
	crosshair.set_pos(mousePos)
	var lookDirection = crosshair.get_pos().x - playerNode.get_pos().x
	# Flip player if crosshair is behind
	if ((playerNode.orientation == playerNode.ORIENTATION_LEFT and lookDirection > 0) 
	or (playerNode.orientation == playerNode.ORIENTATION_RIGHT and lookDirection < 0)):
		playerNode.scale(Vector2(-1, 1))
		playerNode.orientation = 1 if playerNode.orientation == 0 else 0  # Switch orientation
	
	# Shooting
	if counter < playerNode.cooldown:
		counter += delta
	elif Input.is_action_pressed("fire"):
		var shootDirection = (mousePos - playerPos).normalized()
		var poopNode = poop.instance()
		add_child(poopNode)
		poopNode.set_pos(playerPos)
		poopNode.call("setVelocity", shootDirection)
		poopNode.add_to_group("Projectiles")
		counter = 0
