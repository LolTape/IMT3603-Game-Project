extends CharacterBody2D

@export var max_health: float = 100.0


# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Gets state 
@onready var state: StateComponent = $StateComponent

# Gets the deathsound that will be called later
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

# Movement variables
@export var speed : float
@export var time_to_top_speed : float

@export var dash_speed : float
@export var dash_cooldown : float
@export var dash_i_time : float

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((2.0 * jump_height) / pow(jump_time_to_peak, 2.0)) * 1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var hitbox: HitboxComponent = $HitboxComponent
@onready var attack_sound: AudioStreamPlayer2D = $AttackSound


@export var sprite : AnimatedSprite2D

var dash_cd = 0
## input horizontal direction
var input_h_dir : float 

## Called when the node enters the scene tree for the first time.
## Connects the health component's death signal to the player's death behaviour.
func _ready() -> void:
	health.max_health = max_health
	health.current_health = max_health
	health.state = state
	health.died.connect(_on_died)
	hitbox.monitoring = false

func jump():
	if is_on_floor():
		velocity.y += jump_velocity

func dash(dash_dir: Vector2) -> void: 
	if !state.can_dash() || dash_cd: # if still on cooldown, don't dash
		return

	dash_cd = dash_cooldown
	velocity += dash_dir * dash_speed
	state.set_state(StateComponent.State.IFRAMES, dash_i_time)
	
func gravity() -> float:
	var base_gravity = jump_gravity if velocity.y < 0.0 else fall_gravity
	if !Input.is_action_pressed("jump"): # if jump is release, fall faster
		return 2 * base_gravity
	return base_gravity

var is_attacking: bool = false

func attack() -> void:
	if is_attacking:
		return
		
	is_attacking = true
	attack_sound.play()
	hitbox.monitoring = true

	await get_tree().create_timer(0.2).timeout

	hitbox.monitoring = false
	is_attacking = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dash_cd = max(dash_cd - delta, 0.0)
	if input_h_dir != 0:
		sprite.flip_h = input_h_dir != 1
	if Input.is_action_just_pressed("Attack 1"):
		attack()


func _physics_process(delta: float):
	input_h_dir = Input.get_axis("left", "right")

	if Input.is_action_just_pressed("jump"):
		jump()

	if Input.is_action_just_pressed("dash"):
		dash(Vector2(input_h_dir, 0))


	var target_velocity = input_h_dir * speed
	var acceleration = (speed * delta) / time_to_top_speed 
	velocity.x = move_toward(velocity.x, target_velocity, acceleration)

	velocity.y += gravity() * delta
	move_and_slide()
	
	update_animation()
	
# Animation for the player
func update_animation():
	if not is_on_floor():
		if sprite.animation != "jump":
			sprite.animation = "jump"
		sprite.pause()
		
		# pause sprite so jump animation is correct by time in air
		if velocity.y < -150:
			sprite.frame = 2
		elif velocity.y < -40:
			sprite.frame = 3
		elif velocity.y < 40:
			sprite.frame = 4
		else:
			sprite.frame = 5
	elif velocity.x != 0:
		sprite.play("walking")
	else:
		sprite.play("idle")
	
## Stops the player's physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	state.set_state(StateComponent.State.DEAD, INT64_MAX) # dead for a LOOONNNGG time (about 500 million years)
	set_physics_process(false)
	death_sound.play()
	await death_sound.finished
	queue_free()

	
