extends CanvasLayer

# Hides the menu from start
func _ready():
	hide()

# Clicking Esc to get the pause menu
func _input(event):
	if get_tree().paused and not visible:
		return # If game was paused by something else, like death
	if event.is_action_pressed("pause"):
		toggle_pause()

# Swithcing the game between paused and unpaused
func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	if visible:
		$VBoxContainer/Buttons/ResumeButton.grab_focus()

# Resume button
func on_resume_button_pressed():
	toggle_pause()

# Main menu button
func on_main_menu_button_pressed():
	# Need too unpause the game before going to the title screen
	get_tree().paused = false
	get_tree().change_scene_to_file("res://title_screen.tscn")

# Quit button
func on_quit_button_pressed():
	get_tree().quit()
