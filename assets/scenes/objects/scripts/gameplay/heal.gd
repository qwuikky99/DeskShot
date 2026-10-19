extends Area2D

var heal = 5 * randf_range(1, 2 * global.level)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Heal spawned somewhere!")

func _on_area_entered(area: Area2D) -> void:
	if "hp" in area:
		area.hp += heal
		print("Healed a %s by %d HP" % [area.name, heal])
		self.queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if "hp" in body:
		body.hp += heal
		print("Healed a %s by %d HP" % [body.name, heal])
		self.queue_free()

static func random_spawn_position(node: Node) -> Vector2:
	var viewport_size = node.get_viewport_rect().size
	return Vector2(randf_range(0, viewport_size.x - 100), randf_range(0, viewport_size.y - 100))

static func spawn(position: Vector2, parent: Node):
	var healobj = preload("res://assets/scenes/objects/heal.tscn").instantiate()
	parent.add_child(healobj)
	healobj.position = position
