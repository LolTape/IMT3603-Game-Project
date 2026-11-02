extends PowerupComponent



func init_power():    
    if player.on_dash():
        state.set_state(StateComponent.State.IFRAMES, player.dash_i_time)
        player.CollisionShape2D.disabled = true
    if not player.on_dash():
        player.CollisionShape2D.disabled = false


	