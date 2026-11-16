extends Node2D
## Attach to the root node of every level scene.
## Each level needs: a Marker2D named "PlayerSpawn" and an Area2D named "Exit".

signal level_completed

@onready var exit: Area2D = $Exit


func _ready() -> void:
	exit.body_entered.connect(_on_exit_body_entered)


func _on_exit_body_entered(body: Node2D) -> void:
	print("Exit touched by: ", body.name, " | in player group: ", body.is_in_group("player"))
	if body.is_in_group("player"):
		# Stop the exit from firing twice while the level is being swapped out.
		exit.set_deferred("monitoring", false)
		level_completed.emit()