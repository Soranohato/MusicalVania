extends Node2D
class_name HealthComponent

@export
var MAX_HEALTH: int = 100

@export
var currentHealth: int

func takeDamage(damage:int):
	currentHealth -= damageScaling(damage)
	print("OOF: "+str(currentHealth))
	if currentHealth<=0:
		print("DIE") #TODO

func damageScaling(damage: int) -> int:
	return damage #TODO
