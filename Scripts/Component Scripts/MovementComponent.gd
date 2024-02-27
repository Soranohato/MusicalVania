extends Node2D
class_name MovementComponent

@export
var parent: PhysicsBody2D

@export
var MAX_VELOCITY: float = 100

@export
var horizontalFriction: float = 200

@export
var acceleration: float

func applyFriction(delta: float):
		if parent.velocity.x >= 0:
			parent.velocity.x = maxf(0, parent.velocity.x - horizontalFriction * delta);
		else:
			parent.velocity.x = minf(0, parent.velocity.x + horizontalFriction * delta);

func accelerate(direction:float, delta: float):
	if (direction==0):
		applyFriction(delta)
	else:
		parent.velocity.x = clampf(parent.velocity.x + direction * acceleration * delta, -MAX_VELOCITY, MAX_VELOCITY);

