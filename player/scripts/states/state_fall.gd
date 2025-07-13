class_name State_Fall extends State

@onready var idle: State_Idle = $"../Idle"
@onready var run: State_Run = $"../Run"

const GRAVITY: float = 10

func enter() -> void:
	player.update_animation("jump")

func process(_delta: float) -> State:
	player.velocity.y += GRAVITY

	if player.is_on_floor():
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			return run
		else:
			return idle

	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.move_speed
		player.sprite.scale.x = -1
	elif Input.is_action_pressed("move_left"):
		player.velocity.x = -player.move_speed
		player.sprite.scale.x = 1
	else:
		player.velocity.x = 0

	return null
