class_name VisionComponent
extends Node2D

@onready var vision_ray: RayCast2D = $Vision_Ray

var fov_degrees: float = 90.0
var vision_length: float = 250.0


func in_vision(target: Node2D, facingDirection: int) -> bool:
	var target_diff: Vector2 = target.global_position - global_position
	var target_distance: float = target_diff.length()
	var facing_vector: Vector2
	
	if (target_distance > vision_length):
		return false

	# normalizes the vector to make length 1 while keeping direction
	var target_direction: Vector2 = target_diff.normalized()
	# turns facing direction into facing vector 
	if facingDirection == 1: 
		facing_vector = Vector2.RIGHT
	else:
		facing_vector = Vector2.LEFT
	
	# angle from where wolf if facing to the target. if target is directly to the right and wolf is facing right 
	# it is 0 if the wolf is facing left it becomes 180 or -180
	var angle = facing_vector.angle_to(target_direction)
	
	# abs checks both sides of the cone by showing angles absolute value this used here effectively shows negative values as positive ones
	# fov is divded into two as we removed negative values which is half of the equation (/2) deg_to_rad makes degrees workable with our angle 
	if (abs(angle) > deg_to_rad(fov_degrees/2)):
		return false

	# sets the ray's endpoint to the target's position in vision_ray's local cordinate system
	vision_ray.target_position = vision_ray.to_local(target.global_position)
	vision_ray.force_raycast_update()
	# returns true if the ray collider hits the target first, otherwise it returns false
	return vision_ray.get_collider() == target
