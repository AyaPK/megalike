extends CharacterBody2D

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()

func begin_moving(direction: String, place: Vector2) -> void:
	global_position = place
	if direction == "left":
		velocity.x = -200
	elif direction == "right":
		velocity.x = 200
