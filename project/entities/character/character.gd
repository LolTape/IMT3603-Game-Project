extends CharacterBody2D

@export var acceleration = 500
@export var gravity = 50
@export var jump_height : float = 2
var horizontalDrag = 0.7
# @export var jump_time_to_peak : float
# @export var jump_time_to_descent : float

@onready var jump_speed = -sqrt(jump_height * 1000000)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func jump():
	var on_ground = is_on_floor()
	if on_ground:
		velocity.y += jump_speed

func apply_input():
	var direction = Input.get_axis("left", "right")
	velocity.x += direction * acceleration 

	if Input.is_action_just_pressed("jump"):
		jump()


func _physics_process(delta: float):
	apply_input()
	velocity += Vector2.DOWN * gravity
	velocity.x *= horizontalDrag

	move_and_slide()
	
	
