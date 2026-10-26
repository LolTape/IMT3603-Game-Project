class_name HurtboxComponent
extends Area2D


# The HealthComponent that should receive damage
# when this hurtbox is hit.
@export var health_component: HealthComponent

var invis_time : float

## Applies incoming damage to the associated [HealthComponent].
##
## The hurtbox itself does not manage health. Instead, it forwards
## the damage to the [HealthComponent] assigned in the Inspector.
##
## [param attack_damage] The amount of damage to apply.
func take_hit(attack: float) -> void:
	if !health_component:
		return
	if !invis_time:
		health_component.damage(attack)

func _process(delta: float) -> void:
	invis_time = max(invis_time - delta, 0.0)

func _set_invincibiliy_time(new_i_time: float):
	if new_i_time >= invis_time:
		invis_time = new_i_time
