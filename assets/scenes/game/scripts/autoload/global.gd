extends Node2D

var score: int
var kills: int
var level: int
static var kill_types = {
	"normal": 0,
	"slow": 0,
	"speedy": 0,
	"sneaky": 0,
}
var incremented_lvl = false
var level_formula = 1 + (level * 0.1)
func increment_level():
	level += 1
	announce.show_label("Level Up! Your level: " + str(level))

func _process(_delta: float) -> void:
	if kills % 25 == 0 and kills > 0 and not incremented_lvl:
		incremented_lvl = true
		increment_level()
	elif kills % 25 != 0:
		incremented_lvl = false
