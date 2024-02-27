extends CharacterBody2D

@export
var movementComponent: MovementComponent

@export_group("Vertical Movement Settings")
@export var gravUp = 3500;
@export var gravDown = 4000;
@export var jumpStr = 1200;
@export var airFriction = 0.6;

@export_group("Attack Settings")
@export var attackCooldown = 17.5;

var grounded = false;
var facingDirection = 1;
var attackTimer = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func checkJump():
	var jumpInput = Input.is_action_pressed("Jump");
	if(jumpInput):
		if(grounded):
			velocity.y = -jumpStr;
	else:
		if(!grounded && velocity.y < 0):
			velocity.y *= airFriction;

func processHorizontalMovement(delta):
	var xInput = 0;
	if Input.is_action_pressed("Right"):
		xInput += 1;
		facingDirection = 1;
	if Input.is_action_pressed("Left"):
		xInput -= 1;
		facingDirection = -1;
		
	movementComponent.accelerate(xInput, delta)
	
	#if xInput == 0: #todo: change this so it works for controllers
		##Apply Friction
		#if velocity.x >= 0:
			#velocity.x = maxf(0, velocity.x - frictionSpeed * delta);
		#else:
			#velocity.x = minf(0, velocity.x + frictionSpeed * delta);
	#velocity.x = clampf(velocity.x + xInput * accelSpeed * delta, -maxSpeed, maxSpeed);

func processVerticalMovement(delta):
	checkJump();

	#if(!grounded):
		##apply gravity
		#if(velocity.y < 0 && Input.is_action_pressed("Jump")):
			##going up and holding jump, so use weaker gravity
			#velocity.y += gravUp * delta;
		#else:
			#velocity.y += gravDown * delta;

func attack(delta):
	pass

func processAttack(delta):
	if (attackTimer <= 0):
		if (Input.is_action_pressed("Attack")):
			attackTimer = attackCooldown;
			print("ATTACKING");
			attack(delta);
	else:
		attackTimer -= 1;

func processMovement(delta):
	processAttack(delta);
	processHorizontalMovement(delta);
	processVerticalMovement(delta);
	
	move_and_slide();
	grounded = is_on_floor();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	processMovement(delta);
