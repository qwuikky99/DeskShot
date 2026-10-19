extends Sprite2D
@onready var player = self.get_parent()
@export var distance = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = get_global_mouse_position() - player.global_position
	self.position = direction.normalized() * distance
	self.rotation = direction.angle() + PI / 2
