class_name GravityComponent
extends Node2D
## Component for implementing gravity.
##
## Nodes with this class as a child will now be accelerated downwards.
## The parent will be accelerated slower based on the airFriction if it is moving down.

## A reference to the parent that experiences gravity.
@export
var parent: CharacterBody2D

## The amount of gravity the parent experiences.
@export
var gravity: float

## The amount of airFriction experienced by the parent when falling down.
@export_range(0,1)
var airFriction: float = 0.6

func _physics_process(delta):
	if parent.is_on_floor(): #BUG The test dummy always thinks its on the floor and doesn't fall.
		return
	
	if parent.velocity.y>0:
		# Applying air friction when moving down.
		parent.velocity.y += gravity*airFriction*delta
	else:
		# No air friction when moving up.
		parent.velocity.y += gravity*delta
