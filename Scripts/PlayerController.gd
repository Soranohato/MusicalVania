class_name Player
extends CharacterBody2D
## Class to control the player input.
##
## This class handles player movement, jumping and attacking.
## It also requires a reference to a movementComponent, hitboxComponent and jumpComponent.

## Handles movement implementation.
@export
var movementComponent: MovementComponent

## Handles attack implementation.
@export
var hitboxComponent: HitboxComponent

## Handles jump implementation
@export
var jumpComponent: JumpComponent

var grounded = false

## Keeps track of what direction the player is facing.
## +1: Right, -1: Left
var facingDirection = 1

## Handles input for jumping.
## Also calls the jumpComponent accordingly
func checkJump():
	var jumpInput = Input.is_action_pressed("Jump")
	if(jumpInput):
		jumpComponent.jump()
	else:
		jumpComponent.jumpAirFriction()

## Handles input for horizontal movement.
## Also calls the movementComponent accordingly
func processHorizontalMovement(delta):
	# Decides movement
	var xInput = 0
	if Input.is_action_pressed("Right"):
		xInput += 1
		facingDirection = 1
	if Input.is_action_pressed("Left"):
		xInput -= 1
		facingDirection = -1
	
	movementComponent.accelerate(xInput, delta)

## Handles input for a basic attack.
## Also calls the hitboxComponent accordingly
func processAttack(delta): #TODO Implement advanced combat features.
	if (!hitboxComponent.attacking):
		if (Input.is_action_pressed("Attack")):
			print("ATTACKING")
			hitboxComponent.startAttack()
		else:
			hitboxComponent.stopAttack()


## Handles input for all movement.
func processMovement(delta):
	processHorizontalMovement(delta)
	checkJump()
	
	move_and_slide()
	grounded = is_on_floor()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processAttack(delta)
	processMovement(delta)
