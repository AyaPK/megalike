class_name Player extends CharacterBody2D

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


@export var move_speed: int

var v: Vector2 = Vector2.ZERO

func _ready() -> void:
	state_machine.initialise(self)

func _physics_process(_delta: float) -> void:
	print(velocity.y)
	move_and_slide()

func update_animation(anim_name: String) -> void:
	animation_player.play(anim_name)
