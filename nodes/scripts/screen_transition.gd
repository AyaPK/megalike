class_name Screen_Transition extends Node2D

@onready var camera: Camera2D = $"../Camera"

enum Sides {LEFT, RIGHT}
@export var side: Sides

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	print("entered")
	if side == Sides.LEFT:
		camera.limit_left = int(global_position.x)
	else:
		camera.limit_right = int(global_position.x)
