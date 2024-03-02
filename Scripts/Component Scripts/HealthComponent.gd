class_name HealthComponent
extends Node2D
## Component for keeping track of health.
##
## This keeps track of the parent's max health, current health, and also handles damageScaling.

## The maximum health.
@export
var MAX_HEALTH: int = 100

## The current health. Should be set to the max health by default.
@export
var currentHealth: int

## Applies damage.
func takeDamage(damage:int):
	currentHealth -= damageScaling(damage)
	print("OOF: "+str(currentHealth))
	if currentHealth<=0:
		currentHealth = 0
		print("DIE") #TODO Add death implementation.

## Applies damage scaling to the provided damage, and returns the new scaled damage.
func damageScaling(damage: int) -> int:
	return damage #TODO Scale damage
