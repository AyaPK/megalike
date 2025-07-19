class_name State_Jump extends State

@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"
@onready var jump_shoot: State_Jump_Shoot = $"../JumpShoot"

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
		player.facing = "right"
	elif Input.is_action_pressed("move_left"):
		player.velocity.x = -player.move_speed
		player.sprite.scale.x = 1
		player.facing = "left"
	else:
		player.velocity.x = 0
	
	if Input.is_action_pressed("move_down") and player.on_ladder:
		return climb_down
	elif Input.is_action_pressed("move_up") and player.on_ladder:
		return climb_up
	return null

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("move_up") and player.on_ladder:
		return climb_up
	if Input.is_action_just_pressed("move_down") and player.on_ladder:
		return climb_down
	if Input.is_action_just_pressed("shoot"):
		return jump_shoot
	return null
