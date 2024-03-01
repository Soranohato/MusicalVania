extends Area2D
class_name HurtboxComponent

@export
var healthComponent: HealthComponent

@export
var immunityDuration = 40 #TODO

var immunityTimer = 0



func _process(delta):
	
	if immunityTimer >= 0:
		immunityTimer-=1
		return
	
	var areas: Array[Area2D] = get_overlapping_areas()
	for area in areas:
		if (area is HitboxComponent) and area.attacking:
			print("AHA!")
			healthComponent.takeDamage(area.damageAmount)
			immunityTimer = immunityDuration
