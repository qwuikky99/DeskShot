extends Control

# Variables
#region Object References
@onready var cheat_label = $CheatsLabel
#endregion

#region Enemy Spawning
var selected_enemy_type = 1
var heal = 5
const ENEMY = preload("res://assets/scenes/objects/scripts/gameplay/enemy.gd")
#endregion

## Other
var debug_mode = false
var i = Input # fucking tired of writing Input all the time
var selected_type = 1

func _ready():
	if OS.get_environment("COMPUTERNAME") == "max-laptop":
		debug_mode = true
		cheat_label.text = "DEBUG"

func _process(_delta: float) -> void:
	cheat_label.visible = debug_mode

	if i.is_action_just_pressed("toggle_debug_mode"):
		debug_mode = not debug_mode
	if debug_mode:
		var type_names = ["normal", "slow", "speedy", "sneaky"]

#region spawning enemies
		if i.is_action_just_pressed("debug_spawn_enemy"):
			var type = type_names[selected_enemy_type - 1]

			print("Spawned a new enemy with ID ", selected_enemy_type, "!")
			announce.show_label("Spawned a new enemy with ID " + str(selected_enemy_type) + "! (%s)" % type_names[selected_enemy_type - 1].capitalize())

			ENEMY.spawn_enemy(type, ENEMY.random_spawn_position(self), get_parent())
		if i.is_action_just_pressed("debug_cycle_enemy"):
			selected_enemy_type += 1
			if selected_enemy_type > len(ENEMY.types):
				selected_enemy_type = 1
			announce.show_label("Cycled spawn enemy ID to " + str(selected_enemy_type) + "! (%s)" % type_names[selected_enemy_type - 1].capitalize())
#endregion

#region health-related
		if i.is_action_just_pressed("debug_heal"):
			get_tree().get_first_node_in_group("player").hp += heal
		if i.is_action_just_pressed("debug_inc_heal"):
			heal += 5
		if i.is_action_just_pressed("debug_dec_heal"):
			heal -= 5
		if i.is_action_just_pressed("debug_die"):
			get_tree().get_first_node_in_group("player").hp = -1
#endregion
