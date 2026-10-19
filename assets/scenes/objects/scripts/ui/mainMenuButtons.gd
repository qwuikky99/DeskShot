extends Control

#region object references

#region play button
@onready var player = $"/root/menu/player"
@onready var rect = $"/root/menu/UI/TextureRect"
@onready var logo = $"/root/menu/UI/DeskshotLogo"
@onready var UI = $"/root/menu/UI"
#endregion
#endregion

#region scene related stuff
func _on_play_pressed() -> void:
	var tweens = []
	var delay = 0.0
	for node in UI.get_children():
		var tween = create_tween()
		tween.tween_interval(delay)
		tween.tween_property(node, "position", Vector2(node.position.x - 1000, node.position.y), 0.5).set_trans(Tween.TRANS_QUAD)
		tweens.append(tween)
		delay += 0.05
	var tween = create_tween()
	tween.parallel().tween_property(player, "position", Vector2(595, 329), 1).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(player, "scale", Vector2(0.75, 0.75), 1).set_trans(Tween.TRANS_QUAD)
	await get_tree().create_timer(delay + 0.5).timeout
	get_tree().change_scene_to_file("res://assets/scenes/game/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
#endregion

#region socials
func _on_twitter_pressed() -> void:
	OS.shell_open("https://x.com/qwuikky99")

func _on_discord_pressed() -> void:
	OS.shell_open("https://discord.gg/23wHhVg5QW")

func _on_git_hub_pressed() -> void:
	OS.shell_open("https://github.com/qwuikky99/DeskShot")
#endregion
