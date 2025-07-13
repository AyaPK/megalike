class_name State_Jump extends State

@onready var fall: State_Fall = $"../Fall"

const JUMP_FORCE: float = -325
const GRAVITY: float = 10
const JUMP_CUTOFF_SPEED: float = -100

func enter() -> void:
	player.velocity.y = JUMP_FORCE
	player.update_animation("jump")

func process(_delta: float) -> State:
	player.velocity.y += GRAVITY

	if !Input.is_action_pressed("jump") and player.velocity.y < JUMP_CUTOFF_SPEED:
		player.velocity.y = JUMP_CUTOFF_SPEED

	if player.velocity.y >= 0:
		return fall

	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.move_speed
		player.sprite.scale.x = -1
	elif Input.is_action_pressed("move_left"):
		player.velocity.x = -player.move_speed
		player.sprite.scale.x = 1
	else:
		player.velocity.x = 0


	return null
