class_name State_Climb_Shoot extends State

@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: Node = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"
@onready var climb_shoot: State_Climb_Shoot = $"."

const BASIC_BULLET = preload("res://player/basic_bullet.tscn")

func _ready() -> void:
	pass

func enter() -> void:
	print("a")
	player.animation_player.play()
	player.update_animation("climb_shoot")
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
	player.velocity = Vector2.ZERO
	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return fall
	if Input.is_action_just_pressed("move_up") and player.on_ladder:
		return climb_up
	if Input.is_action_just_pressed("move_down") and player.on_ladder:
		return climb_down
	elif Input.is_action_just_pressed("shoot"):
		enter()
	return null
