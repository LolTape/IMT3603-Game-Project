class_name HitboxComponent
extends Area2D

# Amount of damage this hitbox deals when it hits a hurtbox.
@export var attack_damage: float = 10.0


## Connects the hitbox to the [signal Area2D.area_entered] signal.
##
## When another Area2D enters this hitbox, [method _on_area_entered]
## is called to determine whether the area is a [HurtboxComponent].
func _ready() -> void: 
    area_entered.connect(_on_area_entered)



## Handles areas entering the hitbox.
##
## If the entered area is a [HurtboxComponent], the hitbox's damage
## amount is passed to it.
##
## [param area] The Area2D that entered the hitbox.
func _on_area_entered(area):
    # Tells the hurtbox to apply this hit's damage
    # to its associated HealthComponent.
    if area is HurtboxComponent:
        area.take_hit(attack_damage)