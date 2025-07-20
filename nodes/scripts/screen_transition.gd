class_name Horizonal_Transition extends Node2D

@onready var camera: Camera = $"../Camera"
@onready var collider: CollisionShape2D = $collider

enum Sides {LEFT, RIGHT}
@export var side: Sides
@export var is_transition: bool
@export var default_collision: bool = false

const CAMERA_SHIFT_DISTANCE := 190
const CAMERA_SCROLL_AMOUNT := 375
const CAMERA_SCROLL_STEP := 2
const CAMERA_SCROLL_FRAMES := CAMERA_SCROLL_AMOUNT / CAMERA_SCROLL_STEP
const CAMERA_LIMIT_BUFFER := 999999
const PLAYER_GROUP := "player"

func _ready() -> void:
	collider.disabled = !default_collision

func _process(_delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if side == Sides.LEFT:
		camera.limit_left = int(global_position.x)
	else:
		camera.limit_right = int(global_position.x)

func _on_transition_area_body_entered(body: Node2D) -> void:
	if not is_transition:
		return

	is_transition = false
	camera.transitioning = true
	camera.global_position.x -= CAMERA_SHIFT_DISTANCE

	var players := get_tree().get_nodes_in_group(PLAYER_GROUP)
	for player in players:
		player.process_mode = Node.PROCESS_MODE_DISABLED

	await get_tree().create_timer(1.0).timeout

	camera.limit_right += CAMERA_LIMIT_BUFFER

	for i in range(CAMERA_SCROLL_FRAMES):
		camera.global_position.x += CAMERA_SCROLL_STEP
		await get_tree().process_frame

	camera.limit_left = global_position.x - 15
	camera.transitioning = false

	for player in players:
		player.process_mode = Node.PROCESS_MODE_ALWAYS

	global_position.x -= 15
	collider.disabled = false
