class_name State_Run extends State

@export var move_speed:float = 200.0
@onready var idle: State_Idle = $"../Idle"
@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("run")

func exit() -> void:
	pass

func process(_delta: float) -> State:
	if !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		return idle
		
	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.move_speed
		player.sprite.scale.x = -1

	elif Input.is_action_pressed("move_left"):
		player.velocity.x = -player.move_speed
		player.sprite.scale.x = 1

	if Input.is_action_just_pressed("jump"):
		return jump
	if !player.is_on_floor():
		return fall
	
	if Input.is_action_pressed("move_down") and player.on_ladder:
		return climb_down
	elif Input.is_action_pressed("move_up") and player.on_ladder:
		return climb_up
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
