class_name State_Idle extends State

@onready var run: State_Run = $"../Run"
@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"
@onready var idle_shoot: State_Idle_Shoot = $"../IdleShoot"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("idle")

func exit() -> void:
	pass

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if !player.is_on_floor() and !player.on_ladder:
		return fall
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		return run
	elif Input.is_action_just_pressed("jump"):
		return jump
	elif Input.is_action_just_pressed("move_up") and player.on_ladder:
		return climb_up
	elif Input.is_action_just_pressed("move_down") and player.on_ladder:
		return climb_down
	elif Input.is_action_just_pressed("shoot"):
		return idle_shoot
	return null
