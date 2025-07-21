class_name Vertical_Transition extends Node2D

@onready var camera: Camera = $"../Camera"

enum Sides {TOP, BOTTOM}

const CAMERA_SHIFT_DISTANCE := 190
const CAMERA_SCROLL_AMOUNT := 208
const CAMERA_SCROLL_STEP := 2
const CAMERA_SCROLL_FRAMES := CAMERA_SCROLL_AMOUNT / CAMERA_SCROLL_STEP
const CAMERA_LIMIT_BUFFER := 999999
const PLAYER_GROUP := "player"

@export var sides: Sides

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	camera.transitioning = true

	var players := get_tree().get_nodes_in_group(PLAYER_GROUP)
	for player in players:
		player.process_mode = Node.PROCESS_MODE_DISABLED

	await get_tree().create_timer(1.0).timeout

	for i in range(CAMERA_SCROLL_FRAMES):
		camera.global_position.y -= CAMERA_SCROLL_STEP
		await get_tree().process_frame
		
	camera.transitioning = false

	for player in players:
		player.process_mode = Node.PROCESS_MODE_ALWAYS

	queue_free()
