extends Node2D
class_name GravityComponent

@export
var parent: CharacterBody2D

@export
var gravity: float

@export
var airFriction: float = 0.6

func _physics_process(delta):
	if parent.is_on_floor():
		return
	
	if parent.velocity.y>0:
		parent.velocity.y += gravity*airFriction*delta
	else:
		parent.velocity.y += gravity*delta
