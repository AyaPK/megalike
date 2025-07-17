class_name State_Idle_Shoot extends State

@onready var run: State_Run = $"../Run"
@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"

const BASIC_BULLET = preload("res://player/basic_bullet.tscn")

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("idle_shoot")
	var bullet: CharacterBody2D = BASIC_BULLET.instantiate()
	player.get_parent().add_child(bullet)
	bullet.global_position = player.shot_origin.global_position
	bullet.begin_moving("right")

func exit() -> void:
	pass

func process(_delta: float) -> State:
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
		player.restart_animation()
		enter()
	return null
