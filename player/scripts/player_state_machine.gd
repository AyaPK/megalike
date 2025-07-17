class_name PlayerStateMachine extends Node

var states:Array[State]
var previous_state:State
var current_state:State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	changeState(current_state.process(delta))

func _physics_process(delta: float) -> void:
	changeState(current_state.process(delta))

func _unhandled_input(event: InputEvent) -> void:
	changeState(current_state.handle_input(event))

func initialise(_player:Player) -> void:
	states = []

	
	for state in get_children():
		if state is State:
			states.append(state)
	if states.size():
		states[0].player = _player
		changeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func changeState(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.exit()
	
	previous_state = current_state
	current_state = new_state
	current_state.enter()
