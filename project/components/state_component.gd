class_name StateComponent
extends Node

## Tracks the object's overall combat/state flow so other systems can react
## consistently to movement, damage, and attack permissions.
enum State { NORMAL, STUNNED, IFRAMES, DEAD }

signal state_changed(new_state: State)

## The current active state for the entity.
var state_stack: Array = [[State.NORMAL, INT64_MAX]]
## Flags used by other systems to decide whether a specific action is valid.
var is_attacking: bool = false
var is_dashing: bool = false

## Updates the current state only when the entity is still alive and the state
## is actually changing.
func set_state(new_state: State, duration: float) -> void:
	if get_state() == State.DEAD:
		return

	var expiration_time = Time.get_ticks_msec() + round(duration*1000);

	state_stack.push_back([new_state, expiration_time]);
	
	state_changed.emit(get_state())

## Get most recent state (and potentially cleanup stack)
func get_state() -> State:		
	while true:
		var pair = state_stack.back()
		var state = pair[0]
		var expiration = pair[1]
		if Time.get_ticks_msec() > expiration:
			state_stack.pop_back();
			continue
		return state

	return State.NORMAL

## Attacking is allowed in the normal and invulnerability states.
func can_attack() -> bool:
	return get_state() == State.NORMAL or get_state() == State.IFRAMES

## Dashing is permitted in the same states as attacking.
func can_dash() -> bool:
	return get_state() == State.NORMAL or get_state() == State.IFRAMES

## Damage can be taken unless the entity is invulnerable or already dead.
func can_take_damage() -> bool:
	return get_state() != State.IFRAMES and get_state() != State.DEAD

