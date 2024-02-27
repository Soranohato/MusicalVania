extends Area2D
class_name HurtboxComponent

@export
var healthComponent: HealthComponent

@export
var immunityDuration = 4 #TODO

func _on_area_entered(area):
	if not (area is HitboxComponent):
		return
	healthComponent.takeDamage(area.damageAmount)
