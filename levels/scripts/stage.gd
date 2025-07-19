extends Node2D

const PLAYER = preload("res://player/player.tscn")

@onready var player_start: Node2D = $PlayerStart
@onready var camera: Camera = $Camera

func _ready() -> void:
	var player: Player = PLAYER.instantiate()
	add_child(player)
	player.global_position = player_start.global_position
	player_start.queue_free()
	camera.player = player
	
func _process(_delta: float) -> void:
	pass
