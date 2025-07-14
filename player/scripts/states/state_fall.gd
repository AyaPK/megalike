class_name State_Fall extends State

@onready var idle: State_Idle = $"../Idle"
@onready var run: State_Run = $"../Run"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"

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

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("move_up") and player.on_ladder:
		return climb_up
	if Input.is_action_just_pressed("move_down") and player.on_ladder:
		return climb_down
	return null
