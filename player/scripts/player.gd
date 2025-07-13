extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

# Movement
const SPEED := 120.0
const JUMP_FORCE := -260.0
const GRAVITY := 800.0

# Jump Assist
const COYOTE_TIME := 0.05
const JUMP_BUFFER := 0.1

# === State ===
var v: Vector2 = Vector2.ZERO
var coyote_timer := 0.0
var jump_buffer_timer := 0.0

func _physics_process(delta: float) -> void:
	handle_input()
	apply_gravity(delta)
	apply_jump(delta)
	move_and_slide()
	update_timers(delta)

func handle_input() -> void:
	var input_dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * SPEED
	
	if velocity.x > 0:
		sprite_2d.scale.x = -1
	elif velocity.x < 0:
		sprite_2d.scale.x = 1
	
	if velocity != Vector2.ZERO:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	
	if velocity.y != 0:
		animation_player.play("jump")
	
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer_timer = JUMP_BUFFER

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		coyote_timer = COYOTE_TIME
		velocity.y = 0.0

func apply_jump(_delta: float) -> void:
	if (jump_buffer_timer > 0 and coyote_timer > 0):
		velocity.y = JUMP_FORCE
		jump_buffer_timer = 0
		coyote_timer = 0

	if Input.is_action_just_released("ui_up") and velocity.y < 0:
		velocity.y *= 0.5

func update_timers(delta: float) -> void:
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
