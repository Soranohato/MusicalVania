extends Node2D
class_name JumpComponent

@export
var parent: CharacterBody2D

@export
var jumpStr: float

@export
var jumpFriction: float

func jump():
	if (parent.is_on_floor()):
		parent.velocity.y = -jumpStr

func jumpAirFriction():
	if(!parent.is_on_floor() && parent.velocity.y < 0):
		parent.velocity.y *= jumpFriction
	
