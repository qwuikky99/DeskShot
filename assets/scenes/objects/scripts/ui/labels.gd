# labels.gd
extends Control

@onready var kills = $kills
@onready var score = $score
@onready var level = $level
@onready var health = $hp
@onready var player = get_tree().get_first_node_in_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	kills.text = "Kills: %d" % global.kills
	score.text = "%d" % global.score
	level.text = "Level %d" % global.level
	health.text = "%d" % player.hp + "/" + str(player.maxhp) + " HP"
