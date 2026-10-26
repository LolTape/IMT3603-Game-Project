extends CharacterBody2D

@export var speed: float = 75.0
@export var max_health: float = 100.0

# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

var player: CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.max_health = max_health
	health.current_health = max_health

func _physics_process(delta: float) -> void:
	if player == null:
		return

	# Calculate the direction from the Wolf to the Player.
	var direction := global_position.direction_to(player.global_position)

	# Move directly toward the Player.
	global_position += direction * speed * delta


## Stops the entity physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	set_physics_process(false)
	death_sound.play()
	await death_sound.finished
	queue_free()
