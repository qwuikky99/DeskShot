extends Node

const ENEMY = preload("res://assets/scenes/objects/scripts/gameplay/enemy.gd")
const HEAL  = preload("res://assets/scenes/objects/scripts/gameplay/heal.gd")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var objects = $"../gameplay_objects"
@onready var scene = $"/root/main" 

func _ready():
	self.add_to_group("enemies")
	spawn_loop()

func spawn_loop():
	while true:
		var waiting = randf_range(0.1, 3.0)
		var type = ENEMY.types_array.pick_random()
		await get_tree().create_timer(waiting).timeout
		ENEMY.spawn_enemy(type, ENEMY.random_spawn_position(player), get_parent())
func heal_spawn():
	if randi_range(1, 1000) == 1:
		HEAL.spawn(HEAL.random_spawn_position(scene), objects)
		print("Heal spawned!")

func _process(_delta: float):
	heal_spawn()
