extends Area2D
class_name HitboxComponent

@export
var damageAmount: int = 0

var attacking: bool = false

func startAttack():
	attacking = true

func stopAttack():
	attacking = false
