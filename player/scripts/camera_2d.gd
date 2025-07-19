class_name Camera extends Camera2D

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		global_position.x = player.global_position.x
