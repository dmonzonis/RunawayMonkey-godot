extends "entity.gd"

var cooldown = 0.3

func _ready():
	speed = 250
	maxHealth = 3
	health = maxHealth
	add_to_group("Player")
	
func modifyVelocity(delta):
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("move_up")):
		velocity.y -= 1
	if (Input.is_action_pressed("move_down")):
		velocity.y += 1
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 1
	if (Input.is_action_pressed("move_right")):
		velocity.x += 1
	velocity = velocity.normalized() * speed

func update(delta):
	modifyVelocity(delta)

func damage(amount):
	health -= amount
	if amount > 0:
		get_node("sound").play("chimp_cry")
	if health <= 0:
		# Restart the game
		# TODO: send to a game over screen
		var currentScene = get_tree().get_current_scene().get_filename()
		get_tree().change_scene(currentScene)
	if health >= maxHealth:
		health = maxHealth

func _on_player_area_enter(area):
	if area.is_in_group("Enemy"):
		damage(1) # TODO: change damage depending on enemy
		area.queue_free()
