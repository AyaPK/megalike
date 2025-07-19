class_name State_Run_Shoot extends State

@export var move_speed:float = 200.0
@onready var idle: State_Idle = $"../Idle"
@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"

const BASIC_BULLET = preload("res://player/basic_bullet.tscn")

func _ready() -> void:
	pass

func enter() -> void:
	if player.animation_player.current_animation != "run_shoot":
		var pos: int = player.animation_player.current_animation_position
		player.update_animation("run_shoot")
		player.animation_player.seek(pos)
	
	var bullet: CharacterBody2D = BASIC_BULLET.instantiate()
	player.get_parent().add_child(bullet)
	var start_pos: Vector2
	if player.facing == "left":
		start_pos = player.shot_origin_left.global_position
	else:
		start_pos = player.shot_origin_right.global_position
	bullet.begin_moving(player.facing, start_pos)

func exit() -> void:
	pass

func process(_delta: float) -> State:
	if !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		return idle
		
	if Input.is_action_pressed("move_right"):
		player.velocity.x = player.move_speed
		player.sprite.scale.x = -1
		player.facing = "right"

	elif Input.is_action_pressed("move_left"):
		player.velocity.x = -player.move_speed
		player.sprite.scale.x = 1
		player.facing = "left"


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
	if Input.is_action_just_pressed("shoot"):
		enter()
	return null
