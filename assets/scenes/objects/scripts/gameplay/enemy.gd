extends CharacterBody2D

@export var speed: float
@export var damage: float
@export var hp: float
@export var type: String

@onready var anim = $"AnimatedSprite2D"
@onready var player = get_tree().get_first_node_in_group("player")
@onready var coll = $"CollisionShape2D"

var enemy_spawner = preload("res://assets/scenes/objects/enemy.tscn")
var is_sneaky_visible = false
var knockback_velocity = Vector2.ZERO

static var types = {
	"normal": { "id": 1, "speed": 10, "damage": 3, "hp": 3, "score": 50  },
	"slow":   { "id": 2, "speed": 6,  "damage": 5, "hp": 5, "score": 75  },
	"speedy": { "id": 3, "speed": 15, "damage": 1, "hp": 1, "score": 75  },
	"sneaky": { "id": 4, "speed": 10, "damage": 3, "hp": 5, "score": 100 },
}
static var types_array = [ "normal", "slow", "speedy", "sneaky"]

static func random_spawn_position(node: Node) -> Vector2:
	var viewport_size = node.get_viewport_rect().size
	var side = randi_range(0, 3)
	match side:
		0: return Vector2(randf_range(0, viewport_size.x), -50)
		1: return Vector2(randf_range(0, viewport_size.x), viewport_size.y + 50)
		2: return Vector2(-50, randf_range(0, viewport_size.y))
		3: return Vector2(viewport_size.x + 50, randf_range(0, viewport_size.y))

	return Vector2.ZERO

static func spawn_enemy(enemytype: String, spawn_position: Vector2, parent: Node):
	if not parent.get_tree().get_first_node_in_group("player"):
		return
	var enemy = preload("res://assets/scenes/objects/enemy.tscn").instantiate()

	enemy.speed = types[enemytype]["speed"] * 10 * global.level_formula
	enemy.damage = types[enemytype]["damage"] * global.level_formula
	enemy.hp = types[enemytype]["hp"] * global.level_formula
	enemy.type = enemytype

	parent.add_child(enemy)
	enemy.anim.animation = enemytype
	enemy.anim.play()
	enemy.global_position = spawn_position

func _physics_process(delta: float):
	# complex enemy behaviour
	# ("complex" in this context means "something that doesn't just change a value")
	if type == "sneaky":
		var should_be_visible = global_position.distance_to(player.global_position) <= 200
		if should_be_visible != is_sneaky_visible:
			is_sneaky_visible = should_be_visible
			var tween = create_tween()
			tween.tween_property(self, "modulate:a", 1.0 if should_be_visible else 0.0, 0.2)
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed + knockback_velocity
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * delta)
	move_and_slide()

func _ready() -> void:
	# init enemy configs
	if type == "sneaky":
		self.modulate.a = 1.0
		await get_tree().create_timer(0.6).timeout
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
	if type == "speedy":
		coll.scale = Vector2(0.72, 0.72)
