extends Node


#region StateMachine Example Usage
#  StateMachine
#    Idle
#    Chase
#    Attack
#    Dead
#endregion

@export var initial_state: State
var current_state: State
#
var states := {}

func _ready() -> void:
  for state in get_children():
    if state is State:
      states[state.name.to_lower()] = state
      state.transition_to.connect(on_state_transition_to)

  if initial_state:
    initial_state._enter()
    current_state = initial_state

func _process(delta: float) -> void:
  if current_state:
    current_state._update(delta)

func _physics_process(delta: float) -> void:
  if current_state:
    current_state._physics_update(delta)

func on_state_transition_to(state: State, new_state_name: String) -> void:
  if state != current_state:
    return

  var new_state = states.get(new_state_name.to_lower())
  assert(new_state, "State not found: %s" % new_state_name)
  if !new_state:
    return

  if current_state:
    current_state._exit()

  new_state._enter()
  current_state = new_state
