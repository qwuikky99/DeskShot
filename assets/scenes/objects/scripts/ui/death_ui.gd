extends Control

@onready var quit = $DeathQuitButton
@onready var menu = $DeathMenuButton

func _on_death_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/game/menu.tscn")

func _on_death_quit_button_pressed() -> void:
	get_tree().quit()

func _on_death_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/game/main.tscn")
