class_name State_Jump_Shoot extends State

@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: State_Climb_Up = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"

const BASIC_BULLET = preload("res://player/basic_bullet.tscn")

const JUMP_FORCE: float = -325
const GRAVITY: float = 10
const JUMP_CUTOFF_SPEED: float = -100

func enter() -> void:
	player.update_animation("jump_shoot")
	
	var bullet: CharacterBody2D = BASIC_BULLET.instantiate()
	player.get_parent().add_child(bullet)
	var start_pos: Vector2
	if player.facing == "left":
		start_pos = player.shot_origin_left.global_position
	else:
		start_pos = player.shot_origin_right.global_position
	bullet.begin_moving(player.facing, start_pos)

func process(_delta: float) -> State:
	player.velocity.y += GRAVITY
	
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
		enter()
	return null
