class_name HitboxComponent
extends Area2D
## This component handles dealing damage.
##
## This component should cause Hurtbox components to take damage.

## The amount of damage this hitbox deals per hit.
@export
var damageAmount: int = 0

## A boolean to keep track of wether the hitbox is active or not.
var attacking: bool = false

## Activates the hitbox.
func startAttack():
	attacking = true

## Deactivates the hitbox.
func stopAttack():
	attacking = false
