class_name HealthComponent 
extends Node



# Emitted when the entity's health reaches zero.
# The entity can decide what happens when it dies.
signal died


# Emitted whenever the current health changes.
# Useful for things such as health bars or other UI.
signal health_changed(new_amount: float)


# Maximum amount of health this entity can have.
@export var max_health:= 100.0


# The entity's current health.
# This is initialized to max_health when the component is ready.
var current_health: float


## Initializes the entity's health to its maximum health.
func _ready(): current_health = max_health


## Reduces the entity's current health by the specified damage amount.
##
## Health cannot be reduced below zero. After the damage is applied,
## the [signal health_changed] signal is emitted. If health reaches
## zero, the [signal died] signal is emitted.
##
## [param attack_damage] The amount of damage to inflict.
func damage(attack_damage: float):
	current_health -= max(current_health - attack_damage, 0.0)
	# Tells anything listening that the health value has changed.
	health_changed.emit(current_health)


	# If no health remains, notifies listeners that the entity has died.
	if current_health <= 0.0:
		died.emit()
