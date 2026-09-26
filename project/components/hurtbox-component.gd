class_name HurtboxComponent
extends Area2D


# The HealthComponent that should receive damage
# when this hurtbox is hit.
@export var health_component: HealthComponent


## Applies incoming damage to the associated [HealthComponent].
##
## The hurtbox itself does not manage health. Instead, it forwards
## the damage to the [HealthComponent] assigned in the Inspector.
##
## [param attack_damage] The amount of damage to apply.
func take_hit(attack: float) -> void:
	if health_component:
		health_component.damage(attack)
