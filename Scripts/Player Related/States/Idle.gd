extends State

@export
var fall_state: State

@export
var jump_state: State

@export
var move_state: State

func enter() -> void:
	super()
	

func process_physics(delta: float) -> State:
	#Apply Friction
	if parent.velocity.x!=0:
		if parent.velocity.x >= 0:
			parent.velocity.x = maxf(0, parent.velocity.x - parent.frictionSpeed * delta);
		else:
			parent.velocity.x = minf(0, parent.velocity.x + parent.frictionSpeed * delta);
	
	if !parent.is_on_floor():
		return fall_state
	return null

func process_input(event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("Jump") and parent.is_on_floor():
		return jump_state
		
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		return move_state
	
	return null
