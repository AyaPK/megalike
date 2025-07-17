extends CharacterBody2D

func _ready() -> void:
	begin_moving("right")

func _physics_process(delta: float) -> void:
	move_and_slide()
	pass

func begin_moving(direction: String) -> void:
	if direction == "left":
		velocity.x = -200
	elif direction == "right":
		velocity.x = 200
