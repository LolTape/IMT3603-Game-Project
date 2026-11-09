extends CanvasLayer

# Hides the menu from start
func _ready():
	hide()
	add_to_group("game_over")

# Show the game over screen upon death
func show_game_over():
	get_tree().paused = true
	
	# Fade in the game over screen, starting with invisible screen
	for child in get_children():
		if child is CanvasItem:
			child.modulate.a = 0
	
	show()
	# Play the death sound upon death
	$DeathSound.play()
	
	# Using tween to make the fade in animation
	var tween = create_tween().set_parallel(true)
	
	# Fade in the background
	for child in get_children():
		if child is CanvasItem and child != $VBoxContainer:
			tween.tween_property(child, "modulate:a", 1.0, 0.4)
	# Fade in the text and buttons
	tween.chain().tween_property($VBoxContainer, "modulate:a", 1.0, 0.25)
	
	await tween.finished
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
