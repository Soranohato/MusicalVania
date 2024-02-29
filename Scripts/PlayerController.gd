extends CharacterBody2D

## Handles movement implementation.
@export
var movementComponent: MovementComponent

## Handles attack implementation.
@export
var hitboxComponent: HitboxComponent

@export_group("Vertical Movement Settings")
#@export var gravUp = 3500
#@export var gravDown = 4000
## Controls the force of the jump.
@export var jumpStr = 1200

## Controls the amount of air friction experienced when falling.
@export var airFriction = 0.6

@export_group("Attack Settings")
## Controls the cooldown period between attacks
@export var attackCooldown = 17.5

var grounded = false
var facingDirection = 1
var attackTimer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func checkJump():
	var jumpInput = Input.is_action_pressed("Jump")
	if(jumpInput):
		if(grounded):
			velocity.y = -jumpStr
	else:
		if(!grounded && velocity.y < 0):
			velocity.y *= airFriction

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

func processAttack(delta):
	if (attackTimer <= 0 && !hitboxComponent.attacking):
		if (Input.is_action_pressed("Attack")):
			attackTimer = attackCooldown
			print("ATTACKING")
			hitboxComponent.startAttack()
		else:
			hitboxComponent.stopAttack()
			
	else:
		attackTimer -= 1;

func processMovement(delta):
	processHorizontalMovement(delta)
	checkJump()
	
	move_and_slide()
	grounded = is_on_floor()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processAttack(delta)
	processMovement(delta)
