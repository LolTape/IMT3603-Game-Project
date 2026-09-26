extends CharacterBody2D


# Gets health and is needed for death behaviour.
@onready var health: HealthComponent = $HealthComponent

# Movement variables
@export var speed = 1500

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var fall_speed : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((2.0 * jump_height) / pow(jump_time_to_peak, 2.0)) * 1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0






## Called when the node enters the scene tree for the first time.
## Connects the health component's death signal to the player's death behaviour.
func _ready() -> void:
	health.died.connect(_on_died)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func jump():
	velocity.y += jump_velocity

func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity




func _physics_process(delta: float):
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	if !Input.is_action_pressed("jump") and !is_on_floor():
		velocity.y += fall_gravity * delta

	var direction = Input.get_axis("left", "right")
	var target_velocity = direction * speed
	velocity.x = move_toward(velocity.x, target_velocity, speed/5.0)

	velocity.y += gravity() * delta
	# velocity.y = clamp(velocity.y, INT64_MIN, fall_speed)
	move_and_slide()
	
## Stops the player's physics processing and removes the player
## from the scene when their health reaches zero.
func _on_died() -> void:
	set_physics_process(false)
	queue_free()
