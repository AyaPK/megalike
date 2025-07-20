class_name Player extends CharacterBody2D

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@export var move_speed: int
@onready var shot_origin_left: Node2D = $ShotOriginLeft
@onready var shot_origin_right: Node2D = $ShotOriginRight

var on_ladder: bool = false
var v: Vector2 = Vector2.ZERO
var anim_frame: int = 0
var facing: String = "left"
var shooting: bool = false
@onready var idle: State_Idle = $StateMachine/Idle
@onready var jump: State_Jump = $StateMachine/Jump
@onready var climb: State_Climb_Idle = $StateMachine/ClimbIdle

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

func restart_animation() -> void:
	animation_player.seek(0)

func _on_hitbox_body_entered(_body: Node2D) -> void:
	if _body.get_class() == "TileMapLayer":
		on_ladder = true

func _on_hitbox_body_exited(_body: Node2D) -> void:
	on_ladder = false

func leave_shoot() -> void:
	var state_mapping: Dictionary = {
		"idle": idle,
		"jump": jump,
		"climb": climb,
	}
	var anim_name: String = animation_player.current_animation.replace("_shoot", "")
	animation_player.play(anim_name)
	state_machine.changeState(state_mapping[anim_name])

func set_weapon_palette(color1: Color, color2: Color) -> void:
	var shader_material := $Sprite2D.material as ShaderMaterial
	shader_material.set_shader_parameter("color_to_1", color1)
	shader_material.set_shader_parameter("color_to_2", color2)
