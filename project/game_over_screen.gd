extends CanvasLayer

# Hides the menu from start
func _ready():
	hide()
	add_to_group("game_over")

#show the game over screen upon death
func show_game_over():
	get_tree().paused = true
	show()
	# Play the death sound upon death
	$DeathSound.play()
	$VBoxContainer/Buttons/RetryButton.grab_focus()

# Try again button reloads the current scene again
func on_retry_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

# Main menu button
func on_main_menu_button_pressed():
	# Need too unpause the game before going to the title screen
	get_tree().paused = false
	get_tree().change_scene_to_file("res://title_screen.tscn")

# Quit button
func on_quit_button_pressed():
	get_tree().quit()
