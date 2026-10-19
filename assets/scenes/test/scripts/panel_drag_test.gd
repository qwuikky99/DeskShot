extends Panel

var drag_point = null

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Store the offset between mouse position and window position
				drag_point = get_global_mouse_position() - global_position
			else:
				drag_point = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and drag_point != null:
		global_position = get_global_mouse_position() - drag_point
