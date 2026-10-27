class_name StateComponent
extends Node


enum State { NORMAL, STUNNED, IFRAMES, DEAD}

signal state_changed(new_state: State)

var current_state: State = State.NORMAL	
var is_attacking: bool = false
var is_dashing: bool = false

func change_state(new_state: State) -> void:
	if current_state == State.DEAD: return
	if current_state == new_state: return
	current_state = new_state
	state_changed.emit(current_state)

func can_attack() -> bool:
	return current_state == State.NORMAL or current_state == State.IFRAMES

func can_dash() -> bool:
	return current_state == State.NORMAL or current_state == State.IFRAMES

func can_take_damage() -> bool:
	return current_state != State.IFRAMES and current_state != State.DEAD

