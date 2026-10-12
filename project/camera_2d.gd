extends Camera2D

@onready var player: CharacterBody2D = get_parent() as CharacterBody2D

@export var move_speed : float = 400.0
var original_position : Vector2 = Vector2(0, 0) # original position relative to the player
var camera_target_position: Vector2 = Vector2(0, 80) # position camera should move to downwards, negative for upwards.
var hold_time = 1.0 # seconds to hold for camera to move down/up
var held_time = 0.0 # how long the button has been held
var move_direction : float = 0.0 # 1.0 for down, -1.0 for up, 0.0 for none
var destination : Vector2 # where camera should move to

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0, 0)
	zoom = Vector2(1.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if (
		(Input.is_action_pressed("down") or Input.is_action_pressed("up")) # if player is hold down or up
		and player.is_on_floor() and player.velocity == Vector2(0, 0) # no movement
	):
		held_time += delta

	else: # resets timer and direction if not holding down or up
		held_time = 0.0
		move_direction = 0.0


	if held_time >= hold_time:	
		move_direction = Input.get_axis("up", "down")
		destination = camera_target_position * move_direction  # sets destination based on what direction held
	else: 
		destination = original_position

	position.y = move_toward(position.y, destination.y, move_speed * delta) # move camera to destination