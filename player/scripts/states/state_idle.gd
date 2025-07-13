class_name State_Idle extends State

@onready var run: State_Run = $"../Run"
@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("idle")

func exit() -> void:
	pass

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if !player.is_on_floor():
		return fall
	return null

func physics(_delta: float) -> State:
	return null

func handleInput(_event: InputEvent) -> State:
	if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
		return run
	if Input.is_action_just_pressed("jump"):
		return jump
	return null
