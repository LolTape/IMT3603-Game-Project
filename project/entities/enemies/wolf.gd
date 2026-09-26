extends CharacterBody2D

@export var speed: float = 75.0

var player: CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if player == null:
		return

	# Calculate the direction from the Wolf to the Player.
	var direction := global_position.direction_to(player.global_position)

	# Move directly toward the Player.
	global_position += direction * speed * delta
