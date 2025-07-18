class_name State_Climb_Idle extends State

@onready var jump: State_Jump = $"../Jump"
@onready var fall: State_Fall = $"../Fall"
@onready var climb_up: Node = $"../ClimbUp"
@onready var climb_down: State_Climb_Down = $"../ClimbDown"
@onready var climb_shoot: State_Climb_Shoot = $"../ClimbShoot"

func _ready() -> void:
	pass

func enter() -> void:
	player.update_animation("climb")
	player.animation_player.play()

func exit() -> void:
	pass

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if player.animation_player.current_animation == "climb":
		player.pause_animation()
	
	if Input.is_action_pressed("move_right"):
		player.sprite.scale.x = -1
		player.facing = "right"
	elif Input.is_action_pressed("move_left"):
		player.sprite.scale.x = 1
		player.facing = "left"
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
		return climb_shoot
	return null
