extends Node

@onready var bg = $"/root/ui/AnnouncementLabel/BG"
@onready var label = $"/root/ui/AnnouncementLabel" 
var fade_tween
var show_id = 0

func _ready():
	label.modulate.a = 0.0

func _process(_delta: float) -> void:
	bg.size = label.size
func show_label(showtext: String):
	print("Showing label " + str(label.get_path()))
	show_id += 1
	var current_id = show_id

	label.text = showtext
	label.modulate.a = 1.0; bg.modulate.a = 1.0

	await get_tree().create_timer(1).timeout

	if current_id != show_id:
		return

	fade_tween = create_tween()
	fade_tween.parallel().tween_property(label, "modulate:a", 0.0, 0.5)
	fade_tween.parallel().tween_property(bg, "modulate:a", 0.0, 0.5)
