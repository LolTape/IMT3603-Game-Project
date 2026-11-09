extends PowerupComponent

func _ready() -> void:
	super._ready()
	Signals.on_dash.connect(_on_dash)
	
func _exit_tree() -> void:
	if Signals.on_dash.is_connected(_on_dash):
		Signals.on_dash.disconnect(_on_dash)

func _on_dash() -> void:
	state.set_state(StateComponent.State.IFRAMES, player.dash_i_time)
