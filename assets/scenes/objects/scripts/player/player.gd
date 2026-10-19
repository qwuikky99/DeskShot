extends Node2D

#region variables
@onready var player = $"plr"
@onready var aim = $"plr/aim"
@onready var timer = $"timer"
@onready var deathUI = $"../deathUI"
@onready var enemies = get_tree().get_first_node_in_group("enemies")
const BULLET = preload("res://assets/scenes/objects/bullet.tscn")

#region exports
@export var rotation_speed = 3.0
@export var distance = 100
@export var speed = 250
@export var speed_up_multiplier = 1.5
@export var slow_down_multiplier = 0.5
@export var hp = 30
@export var maxhp = 30
@export var dead = false
#endregion
#endregion

func recoil():
	var previous_frame = player.frame

	var tween = create_tween()
	tween.tween_property(aim, "scale", Vector2(2.500, 1.500), 0.05)
	tween.tween_property(aim, "scale", Vector2(1.825, 1.825), timer.wait_time)

	player.play("shoot")
	await get_tree().create_timer(0.1).timeout
	player.play("default")
	player.frame = previous_frame

func shoot():
	if not dead:
		recoil()
		var bullet = BULLET.instantiate()

		get_node("../bullets").add_child(bullet)
		bullet.global_position = player.global_position
		bullet.direction = (get_global_mouse_position() - player.global_position).normalized()

func _ready() -> void:
	print("[loaded] player.gd")
	add_to_group("player")
	deathUI.modulate.a = 0.0

func _process(delta: float) -> void:
#region movement
	if not dead:
		# movement modification
		var current_speed = speed

		if Input.is_action_pressed("move_speed_up"):
			current_speed *= speed_up_multiplier
		elif Input.is_action_pressed("move_slow_down"):
			current_speed *= slow_down_multiplier

		# basic movement
		if Input.is_action_pressed("move_left"):
			self.position.x -= current_speed * delta
		if Input.is_action_pressed("move_right"):
			self.position.x += current_speed * delta
		if Input.is_action_pressed("move_up"):
			self.position.y -= current_speed * delta
		if Input.is_action_pressed("move_down"):
			self.position.y += current_speed * delta
#endregion

#region shooting
		if Input.is_action_pressed("plr_shoot"):
			if timer.is_stopped():
				shoot()
				timer.start()
#endregion

#region visuals
		var direction = get_global_mouse_position() - player.global_position
		var bob = sin(Time.get_ticks_msec() / 150.0) * 7.5
		aim.position = direction.normalized() * (distance + bob)
		aim.rotation = direction.angle() + PI / 2
#endregion

#region health shenanigans
	hp = clamp(hp, 0, maxhp)
func _on_body_entered(body: CharacterBody2D) -> void:
	if not dead:
		self.hp -= body.damage
		global.score -= 10 * body.damage
		if hp <= 0:
			death()
#endregion

func death():
	dead = true
	deathUI.position = Vector2(deathUI.position.x, deathUI.position.y + 648)
	var tween = create_tween()
	tween.tween_property(deathUI, "modulate:a", 1.0, 1.0).set_ease(Tween.EASE_IN_OUT)
	print("Died! Loser")
