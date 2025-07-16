class_name Player extends CharacterBody2D

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@export var move_speed: int

var on_ladder: bool = false
var v: Vector2 = Vector2.ZERO
var anim_frame: int = 0
@onready var idle: State_Idle = $StateMachine/Idle

var state_mapping: Dictionary = {
	"idle": idle
}

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

func leave_shoot() -> void:
	var anim_name: String = animation_player.current_animation.replace("_shoot", "")
	animation_player.play(anim_name)
	state_machine.changeState(state_mapping[anim_name])
