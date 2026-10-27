class_name StateComponent
extends Node


enum State { NORMAL, STUNNED, DEAD}

signal state_changed(new_state: State)

var current_state: State = State.NORMAL	
var is_attacking: bool = false
var is_dashing: bool = false

func change_state(new_state):
	current_state = State.new_state
