class_name MovementComponent
extends Node2D
## This component handles horizontal motion.
##
## It is able to apply friction, and accelerate the parent.

## The parent to apply motion to.
@export
var parent: PhysicsBody2D

## The maximum amount of velocity to experience.
@export_range(0,100,0.1,"or_greater")
var MAX_VELOCITY: float = 100

## The amount of friction experienced by the parent.
@export
var horizontalFriction: float = 200

## The acceleration felt by the parent.
@export
var acceleration: float

@export
var faceDirectionOfMotion: bool = false

## A boolean to keep track of the parent's direction of motion.
## true: facingLeft, false: facingRight
var facingDirection: bool = false

## Function to apply friction to the parent's horizontal motion.
func applyFriction(delta: float):
		if parent.velocity.x >= 0:
			parent.velocity.x = maxf(0, parent.velocity.x - horizontalFriction * delta);
		else:
			parent.velocity.x = minf(0, parent.velocity.x + horizontalFriction * delta);

## Function to accelerate the parent in a specific direction.
func accelerate(direction:float, delta: float):
	
	# If no direction is provided, we just slow the parent down due to friction.
	if (direction == 0):
		applyFriction(delta)
	else:
		parent.velocity.x = clampf(parent.velocity.x + direction * acceleration * delta, -MAX_VELOCITY, MAX_VELOCITY);
	
	if (faceDirectionOfMotion):
		var newDirection: bool = false
		
		if (parent.velocity.x < 0):
			newDirection = true
		elif (parent.velocity.x > 0):
			newDirection = false
		
		## Ensuring the parent faces the direction of motion.
		if (parent.velocity.x != 0) and (facingDirection!=newDirection):
			#TODO Make a separate component to handle this or an export boolean. That way we can reuse this for moving platforms.
			parent.scale.x = -1
			facingDirection = newDirection

