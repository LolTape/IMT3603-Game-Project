extends Camera2D

@onready var player: CharacterBody2D = get_parent() as CharacterBody2D

@export var move_speed : float = 400.0
@export var time_to_hold = 0.5 # seconds to hold for camera to move down/up
@export var camera_target_position: Vector2 = Vector2(0, 80) # position camera should move to downwards, negative for upwards.

var original_position : Vector2 = Vector2(0, 0) # original position relative to the player
var held_time = 0.0 # how long the button has been held
var move_direction : float = 0.0 # 1.0 for down, -1.0 for up, 0.0 for none


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0, 0)
	zoom = Vector2(1.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# checks if player is holding up/down, while standing still on the ground.
	if (standing_still() and get_move_direction()): 
		held_time += delta
	
	release_camera_on_movement_or_release()
	
	# moves camera based on direction and time held
	if held_long_enough():	
		move_camera_to_destination(camera_target_position * move_direction) # sends target position based on what direction held


# returns true if up or down is held, and sets move_direction to the direction held.
func get_move_direction() -> bool:
	if !move_direction:
		move_direction = Input.get_axis("up", "down") 
	return move_direction 


# move camera to destination
func move_camera_to_destination(destination : Vector2):
	position.y = move_toward(position.y, destination.y, move_speed * get_process_delta_time())


 # checks if player is standing still on the ground
func standing_still() -> bool:
	return player.is_on_floor() and player.velocity == Vector2(0, 0)


func held_long_enough() -> bool:
	return held_time >= time_to_hold


# resets camera position, direction and held time if player releases button or starts moving
func release_camera_on_movement_or_release() -> void:
	if (
		(move_direction == 1.0 and Input.is_action_just_released("down"))
		or (move_direction == -1.0 and Input.is_action_just_released("up"))
		or not standing_still()
	):
		move_direction = 0.0
		held_time = 0.0

	if position != original_position and not held_long_enough():
		move_camera_to_destination(original_position) # resets camera pos
