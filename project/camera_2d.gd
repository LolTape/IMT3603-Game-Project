extends Camera2D


@export var move_speed : float = 400.0
var original_position : Vector2 = Vector2(0, 0) # original position relative to the player
var camera_target_position: Vector2 = Vector2(0, 80) # position camera should move to downwards, negative for upwards.
var hold_time = 1.5 # seconds to hold for camera to move down/up
var move_down : bool = false # whether the camera should move down or not
var move_up : bool = false # whether the camera should move up or not
var destination : Vector2 # where camera should move to

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("down"):
		hold_time += delta

		if hold_time >= 1.5:
			move_down = true
			
	else:
		hold_time = 0.0
		move_down = false

	if !move_down and !move_up:
		destination = original_position
	if move_down:
		destination = camera_target_position
	

	position.y = move_toward(position.y, destination.y, move_speed * delta)