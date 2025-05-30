extends Node2D

var current_state: State
var previous_state: State

func _ready():
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

@rpc("call_local", "reliable")
func change_state(state_name: String):
	var next_state = find_child(state_name) as State
	if not next_state:
		push_error("Estado %s no encontrado" % state_name)
		return

	if current_state:
		current_state.exit()

	previous_state = current_state
	current_state = next_state
	current_state.enter()
