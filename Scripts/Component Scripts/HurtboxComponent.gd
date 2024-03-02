class_name HurtboxComponent
extends Area2D
## This component deals with taking damage.
##
## It requires a reference to a HealthComponent to deal the damage to, and also has a period of immunity.

## The health component to deal the damage to.
@export
var healthComponent: HealthComponent

## The number of i-frames the hurtbox has.
@export
var immunityDuration = 40 #TODO

## A timer to keep track of i-frames.
var immunityTimer = 0


## Called every frame.
func _process(delta):
	
	#Check if the hurtbox is currently immune.
	if immunityTimer >= 0:
		immunityTimer-=1
		return
	
	# Getting the overlapping areas and checking if any of them are an active HitboxComponent.
	# If so, causes the HealthComponent to take damage based on the hitboxComponent's damage amount.
	var areas: Array[Area2D] = get_overlapping_areas()
	for area in areas:
		if (area is HitboxComponent) and area.attacking:
			print("AHA!")
			healthComponent.takeDamage(area.damageAmount)
			immunityTimer = immunityDuration
			#break # May or may not want to add...
