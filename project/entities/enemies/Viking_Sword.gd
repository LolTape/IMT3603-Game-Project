extends CharacterBody2D

@export var movement_speed: float = 4.0
@export var max_health: float = 100.0



# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound


@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")



var player: CharacterBody2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.max_health = max_health
	health.current_health = max_health
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))



func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)



func _physics_process(delta: float) -> void:
	if player == null:
		return
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return


	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

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