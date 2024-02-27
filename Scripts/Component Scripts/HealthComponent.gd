extends Node2D
class_name HealthComponent

@export
var MAX_HEALTH: int = 100

var currentHealth: int = MAX_HEALTH

func takeDamage(damage:int):
	currentHealth -= damageScaling(damage)
	print("DIE") #TODO

func damageScaling(damage: int) -> int:
	return damage #TODO
