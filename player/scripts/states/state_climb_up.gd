class_name State_Climb_Up extends State

@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_idle: State_Climb_Idle = $"../ClimbIdle"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("climb")
	player.velocity.x = 0
	print(player.global_position.x)
	player.global_position.x = round(player.global_position.x/8)*8
	print(player.global_position.x)

func exit() -> void:
	pass

func process(_delta: float) -> State:
	if Input.is_action_pressed("move_up") and player.on_ladder:
		player.velocity.y = -100
	else:
		return climb_idle
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return fall
	return null
