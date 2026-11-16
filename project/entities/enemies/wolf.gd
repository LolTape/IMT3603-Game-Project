extends CharacterBody2D


@export var speed: float = 40.0
@export var max_health: float = 100.0

# Vision settings
@export var fov_degrees: float = 90.0
@export var vision_length: float = 250.0
@export var AttackRange: float = 50.0
@export var AttackTimer: float = 10.0
@export var JumpHeigth: float = 15.0


@onready var edge_ray: RayCast2D = $Edge_Detection
@onready var aggro_range: Area2D = $Aggro_Range



# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

@onready var biteHitBox: HitboxComponent = $HitboxComponent

# Gets vision 
@onready var vision: Node2D = $VisionComponent


# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

@onready var wolf_static: Sprite2D = $Sprite2D

var gravity: float


# movement directions
var left = -1
var right = 1


var player: CharacterBody2D
var detected = false
var facingDirection = right
var aggroed = false
var attacking = false

@export var aggroMultiplier: float = 1.5
const beforeJump = 1
const attackTime = 0.5

@export var JumpHeight: float = 15.0
@export var JumpTimeToPeak: float = 0.25




func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	health.max_health = max_health
	health.current_health = max_health
	vision.fov_degrees = fov_degrees
	vision.vision_length = vision_length
	velocity.x = speed
	gravity = (2.0 * JumpHeight) / (JumpTimeToPeak * JumpTimeToPeak) #Formula gotten from gpt
	

# Returns the direction of where the player is from the entity
func _enemyDirection() -> int:
	if (global_position.x - player.global_position.x > 0):
		return left
	else:
		return right

func _swapDirection() -> void:
	biteHitBox.position.x *= -1
	edge_ray.position.x *= -1

	if facingDirection == left:
		facingDirection = right
		wolf_static.flip_h = false
		velocity.x = speed * facingDirection
		
		
	else:
		facingDirection = left
		wolf_static.flip_h = true
		velocity.x = speed * facingDirection
		




func _wolf_bite_attack(fD: int):
	attacking = true 
	velocity.x = 0
	await get_tree().create_timer(beforeJump).timeout
	velocity.x = (speed * fD) * 4
	velocity.y = -gravity * JumpTimeToPeak
	while is_on_floor():
		await get_tree().physics_frame

	while not is_on_floor():
		await get_tree().physics_frame
	velocity.x = 0
	biteHitBox.monitoring = true
	await get_tree().create_timer(attackTime).timeout
	biteHitBox.monitoring = false
	attacking = false
	

	
	# summon hitbox and animation and fly toward target and timers
		


func _physics_process(delta: float) -> void:
	if player == null:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
	
	if attacking:
		move_and_slide()
		return


	if (vision.in_vision(player, facingDirection) and not aggroed):
		aggroed = true
	
	if (aggroed):
		if  not aggro_range.get_overlapping_bodies().has(player):
			aggroed = false
			return
		var eD = _enemyDirection()
		velocity.x = (speed * facingDirection) * aggroMultiplier
		if facingDirection != eD:
			_swapDirection()
			velocity.x = (speed * facingDirection) * aggroMultiplier

		if _in_attack_range():
			_wolf_bite_attack(facingDirection)

		move_and_slide()
	else: 
		move_and_slide()
		if is_on_wall() or not edge_ray.is_colliding():
			_swapDirection()


	



func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()




func _in_attack_range():
	if (abs(player.global_position.x - global_position.x) <= AttackRange):
		return true
	else:
		return false 





## Stops the entity physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	set_physics_process(false)
	death_sound.play()
	await death_sound.finished
	queue_free()
