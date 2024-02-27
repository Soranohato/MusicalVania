extends State

@export
var idle_state: State

@export
var move_state: State

@export
var jump_state: State

func enter() -> void:
	super()

func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravDown * delta
	
	if parent.is_on_floor():
		return idle_state
	
	var movementForce = Input.get_axis("Left","Right") * parent.accelSpeed
	parent.velocity.x = clampf(parent.velocity.x + movementForce * delta, -parent.maxSpeed, parent.maxSpeed);
	
	if parent.is_on_floor():
		if movementForce != 0:
			return move_state
		return idle_state
	
	return null
