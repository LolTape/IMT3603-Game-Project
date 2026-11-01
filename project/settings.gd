extends Control

func _ready():
	$VBoxContainer/Buttons/BackButton.grab_focus()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://title_screen.tscn")
