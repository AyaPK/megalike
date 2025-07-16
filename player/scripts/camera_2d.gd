extends Camera2D

@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = player.global_position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position.x = player.global_position.x
	pass
