extends Area2D

@export var speed = 500.0
@export var knockback = 50.0
@export var damage = 1
@export var type = "player"
@export var piercing = false
@onready var coll = $"CollisionShape2D"
const ENEMY = preload("res://assets/scenes/objects/scripts/gameplay/enemy.gd")
var direction = Vector2.ZERO

func _ready():
	if type == "enemy":
		coll.scale.y = 0.415
		coll.scale.x = 0.415
# move that shiii
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

# culling? i guess
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# kill thing
func _on_body_entered(body: CharacterBody2D):
	print(body.type.capitalize() + " entered the bullet's area!")

	body.hp -= damage
	print("Dealt " + str(damage) + " damage to " + body.type.capitalize() + "!")
	body.knockback_velocity += direction * knockback
	if body.hp <= 0:
		body.queue_free()
		print("Killed a " + body.type.capitalize() + "!")
		global.kills += 1
		global.score += ENEMY.types[body.type]["score"]
		global.kill_types[body.type] += 1
	if not piercing:
		self.queue_free()
