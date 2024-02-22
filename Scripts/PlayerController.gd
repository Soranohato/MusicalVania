extends CharacterBody2D

var maxSpeed = 600;
var accelSpeed = 6000;
var frictionSpeed = 3000;

var gravUp = 3500;
var gravDown = 4000;

var jumpStr = 1200;
var grounded = false;

var facingDirection = 1;

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
			velocity.y *= 0.6;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Get Input
	var xInput = 0;
	if Input.is_action_pressed("Right"):
		xInput += 1;
		facingDirection = 1;
	if Input.is_action_pressed("Left"):
		xInput -= 1;
		facingDirection = -1;
	
	if xInput == 0: #todo: change this so it works for controllers
		#Apply Friction
		if velocity.x >= 0:
			velocity.x = maxf(0, velocity.x - frictionSpeed * delta);
		else:
			velocity.x = minf(0, velocity.x + frictionSpeed * delta);
	velocity.x = clampf(velocity.x + xInput * accelSpeed * delta, -maxSpeed, maxSpeed);
	
	checkJump();
#	print(velocity.x);

	if(!grounded):
		#apply gravity
		if(velocity.y < 0 && Input.is_action_pressed("Jump")):
			#going up and holding jump, so use weaker gravity
			velocity.y += gravUp * delta;
		else:
			velocity.y += gravDown * delta;
	
	move_and_slide();
	
	grounded = is_on_floor();
	pass;
