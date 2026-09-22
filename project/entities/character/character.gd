extends CharacterBody2D

@export var acceleration = 500
var horizontalDrag = 0.7

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((2.0 * jump_height) / pow(jump_time_to_peak, 2.0)) * 1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float):
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	apply_input()
	velocity += Vector2.DOWN * gravity()
	velocity.x *= horizontalDrag

	move_and_slide()
	
func jump():
	velocity.y += jump_velocity

func apply_input():
	var direction = Input.get_axis("left", "right")
	velocity.x += direction * acceleration 

func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity