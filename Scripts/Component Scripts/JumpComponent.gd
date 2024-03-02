class_name JumpComponent
extends Node2D
## This component deals with jumping implementation.
##
## This component causes the parent to jump up based off of a specified Jump Strength.

## The parent to apply jumping to.
@export
var parent: CharacterBody2D

## The strength of the jump.
@export
var jumpStr: float

## Optional friction to apply when the parent is falling.
@export
var jumpFriction: float = 0

## Causes the parent to jump if it is not on the floor.
func jump():
	if (parent.is_on_floor()):
		parent.velocity.y = -jumpStr

## Causes the parent to slow down while falling based on the specified jumpFriction.
func jumpAirFriction():
	if(!parent.is_on_floor() && parent.velocity.y < 0):
		parent.velocity.y *= jumpFriction
	
