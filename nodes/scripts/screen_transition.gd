class_name Horizonal_Transition extends Node2D

@onready var camera: Camera = $"../Camera"
@onready var collider: CollisionShape2D = $collider

enum Sides {LEFT, RIGHT}
@export var side: Sides
@export var is_transition: bool
@export var default_collision: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collider.disabled = !default_collision
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if side == Sides.LEFT:
		camera.limit_left = int(global_position.x)
	else:
		camera.limit_right = int(global_position.x)


func _on_transition_area_body_entered(body: Node2D) -> void:
	if is_transition:
		camera.transitioning = true
		camera.global_position.x -= 190
		for x in get_tree().get_nodes_in_group("player"):
			x.process_mode = Node.PROCESS_MODE_DISABLED
		await get_tree().create_timer(1).timeout
		camera.limit_right += 999999
		for x in range((375/2)):
			camera.global_position.x += 2
			await get_tree().process_frame
		camera.limit_left = global_position.x - 15
		camera.transitioning = false
		for x in get_tree().get_nodes_in_group("player"):
			x.process_mode = Node.PROCESS_MODE_ALWAYS
		is_transition = false
		global_position.x -= 15
		collider.disabled = false
		
	
	
