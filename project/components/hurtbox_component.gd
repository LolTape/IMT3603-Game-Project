class_name HurtboxComponent
extends Area2D


# The HealthComponent that should receive damage
# when this hurtbox is hit.
@export var health_component: HealthComponent

var invis_time : float

signal apply_knockback(strength: float, direction : Vector2)

## Applies incoming damage to the associated [HealthComponent].
##
## The hurtbox itself does not manage health. Instead, it forwards
## the damage to the [HealthComponent] assigned in the Inspector.
##
## [param attack_damage] The amount of damage to apply.
func take_hit(attack: float, attacker: HitboxComponent) -> void:
	if !health_component:
		return
	if !invis_time:
		health_component.damage(attack)
	apply_knockback.emit(1.0, Vector2(attacker.get_parent().facingDirection, -0.3))

func _process(delta: float) -> void:
	invis_time = max(invis_time - delta, 0.0)

