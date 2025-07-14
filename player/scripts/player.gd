class_name Player extends CharacterBody2D

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera_2d: Camera2D = $Camera2D

@export var move_speed: int

var on_ladder: bool = false
var v: Vector2 = Vector2.ZERO

func _ready() -> void:
	state_machine.initialise(self)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func update_animation(anim_name: String) -> void:
	animation_player.play(anim_name)

func pause_animation() -> void:
	animation_player.pause()

func play_animation() -> void:
	animation_player.play()

func _on_hitbox_body_entered(_body: Node2D) -> void:
	on_ladder = true

func _on_hitbox_body_exited(_body: Node2D) -> void:
	on_ladder = false
