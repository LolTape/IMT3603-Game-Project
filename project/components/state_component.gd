class_name StateComponent
extends Node

# Tracks the object's overall combat/state flow so other systems can react
# consistently to movement, damage, and attack permissions.
enum State { NORMAL, STUNNED, IFRAMES, DEAD }

signal state_changed(new_state: State)

# The current active state for the entity.
var current_state: State = State.NORMAL

# Flags used by other systems to decide whether a specific action is valid.
var is_attacking: bool = false
var is_dashing: bool = false

# Updates the current state only when the entity is still alive and the state
# is actually changing.
func change_state(new_state: State) -> void:
	if current_state == State.DEAD:
		return
	if current_state == new_state:
		return
	current_state = new_state
	state_changed.emit(current_state)

# Attacking is allowed in the normal and invulnerability states.
func can_attack() -> bool:
	return current_state == State.NORMAL or current_state == State.IFRAMES

# Dashing is permitted in the same states as attacking.
func can_dash() -> bool:
	return current_state == State.NORMAL or current_state == State.IFRAMES

# Damage can be taken unless the entity is invulnerable or already dead.
func can_take_damage() -> bool:
	return current_state != State.IFRAMES and current_state != State.DEAD

