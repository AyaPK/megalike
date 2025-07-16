class_name State_Climb_Down extends State

@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_idle: State_Climb_Idle = $"../ClimbIdle"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("climb")
	player.velocity.x = 0

func exit() -> void:
	pass

func process(_delta: float) -> State:
	if Input.is_action_pressed("move_down") and player.on_ladder:
		player.velocity.y = 100
	elif player.on_ladder:
		return climb_idle
	else:
		return fall
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return fall
	return null
