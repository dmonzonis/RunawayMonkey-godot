extends Area2D

func _ready():
	pass

func _on_healkit_area_enter(area):
	if area.is_in_group("Player"):
		area.get_node("sound").play("pulse")
		area.damage(-1)
		queue_free()
