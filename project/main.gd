extends Node

## Drag your level scenes into this array in the Inspector, in play order.
@export var levels: Array[PackedScene] = []

@onready var level_container: Node2D = $LevelContainer
@onready var player: CharacterBody2D = $player

var current_level: Node = null
var current_index: int = 0


func _ready() -> void:
	load_level(0)


func load_level(index: int) -> void:
	if index >= levels.size():
		print("Last level finished")  # TODO: hook up win screen / next game state here
		return

	# Remove the old level right away (so old and new never overlap for a frame),
	# then let Godot delete it safely at the end of the frame.
	if current_level:
		level_container.remove_child(current_level)
		current_level.queue_free()

	current_index = index
	current_level = levels[index].instantiate()
	level_container.add_child(current_level)

	# Move the player to the level's spawn point.
	var spawn := current_level.get_node_or_null("PlayerSpawn") as Marker2D
	if spawn:
		player.global_position = spawn.global_position
		player.velocity = Vector2.ZERO
	else:
		push_warning("Level '%s' has no PlayerSpawn Marker2D" % current_level.name)

	# Listen for the level saying it's done.
	if current_level.has_signal("level_completed"):
		current_level.level_completed.connect(_on_level_completed)


func _on_level_completed() -> void:
	# Deferred: this is usually triggered from a physics callback (body_entered),
	# and swapping levels mid-physics-query causes errors.
	load_level.call_deferred(current_index + 1)