extends Control

func _ready():
	
	# Lets you just click enter right away to start game
	$VBoxContainer/StartButton.grab_focus() 

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
