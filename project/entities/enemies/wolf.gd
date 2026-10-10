extends CharacterBody2D

@export var speed: float = 4.0
@export var max_health: float = 100.0



# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

@onready var wolf_static: Sprite2D = $Sprite2D






var player: CharacterBody2D
var detected = false
var facingDirection
var inAttackRange = false

# movement directions
var left = -1
var right = 1


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.max_health = max_health
	health.current_health = max_health
	velocity.x = speed
	

# Returns the direction of where the player is from the entity
func _enemyDirection() -> int:
	if (global_position.x - player.global_position.x > 0):
		return right
	else:
		return left

func _swapDirection() -> void:
	if facingDirection == left:
		facingDirection = right
		wolf_static.flip_h = false
		velocity.x = speed * facingDirection
		
	else:
		facingDirection = left
		wolf_static.flip_h = true
		velocity.x = speed * facingDirection





func _wolf_bite_attack():
	velocity.y = speed
	
	# summon hitbox and animation and fly toward target and timers
		


func _physics_process(delta: float) -> void:
	if player == null:
		return
	if (detected):
		var eD = _enemyDirection()
		if facingDirection != eD:
			_swapDirection()
			move_and_slide()
		if (inAttackRange):
			_wolf_bite_attack()

	else: 
		move_and_slide()
		if is_on_wall():
			_swapDirection()
		
			

	


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
