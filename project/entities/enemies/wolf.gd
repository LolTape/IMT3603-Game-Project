extends CharacterBody2D

@export var speed: float = 4.0
@export var max_health: float = 100.0



# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound


velocity = Vector2.ZERO



var player: CharacterBody2D
var detected = false


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.max_health = max_health
	health.current_health = max_health
	

# Returns false for player being left and true for player being right of the entity
func _enemyDirection() -> bool:
	return global_position.x - player.global_position.x > 0




func _physics_process(delta: float) -> void:
	if player == null:
		return
	if (detected):
		

	else: 
		velocity.x = speed
		

	


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()










## Stops the entity physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	set_physics_process(false)
	death_sound.play()
	await death_sound.finished
	queue_free()