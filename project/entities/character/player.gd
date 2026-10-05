extends CharacterBody2D

@export var max_health: float = 100.0


# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

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

@export var sprite : Sprite2D

var dash_cd = 0
## input horizontal direction
var input_h_dir : float 

signal dash_invincibiliy_time(i_time: float) # give i_frames in seconds

## Called when the node enters the scene tree for the first time.
## Connects the health component's death signal to the player's death behaviour.
func _ready() -> void:
	health.max_health = max_health
	health.current_health = max_health
	health.died.connect(_on_died)

func jump():
	if is_on_floor():
		velocity.y += jump_velocity

func dash(dash_dir: Vector2) -> void: 
	if dash_cd: # if still on cooldown, don't dash
		return

	dash_cd = dash_cooldown
	velocity += dash_dir * dash_speed
	dash_invincibiliy_time.emit(dash_i_time)
	
func gravity() -> float:
	var base_gravity = jump_gravity if velocity.y < 0.0 else fall_gravity
	if !Input.is_action_pressed("jump"): # if jump is release, fall faster
		return 2 * base_gravity

	return base_gravity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dash_cd = max(dash_cd - delta, 0.0)
	if input_h_dir != 0:
		sprite.flip_h = input_h_dir != 1


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
	
## Stops the player's physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	set_physics_process(false)
	death_sound.play()
	await death_sound.finished
	queue_free()

	