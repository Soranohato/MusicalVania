extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State

func enter() -> void:
	super()
	parent.y = -parent.jumpStr

func process_physics(delta:float) -> State:
	if parent.velocity.y < 0:
		if Input.is_action_pressed("Jump"):
			parent.velocity.y *= parent.frictionSpeed*delta
		parent.velocity.y *= parent.gravUp * delta
	else:
		return fall_state
	
	var movementForce = Input.get_axis("Left","Right") * parent.accelSpeed
	parent.velocity.x = clampf(parent.velocity.x + movementForce * delta, -parent.maxSpeed, parent.maxSpeed);
	
	if parent.is_on_floor():
		if movementForce != 0:
			return move_state
		return idle_state
	
	return null
