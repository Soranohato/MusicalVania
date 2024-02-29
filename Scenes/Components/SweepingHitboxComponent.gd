extends HitboxComponent

class_name SweepingHitboxComponent

@export
var sweepAnimation: AnimationPlayer

@export
var animationName: String

func startAttack():
	super.startAttack()
	
	# Playing the sweeping animation. (Should move the hitbox area).
	sweepAnimation.play(animationName)
	
	# Waiting for animation to end to finish attack.
	await sweepAnimation.animation_finished
	
	# Resetting state.
	sweepAnimation.play("RESET")
	stopAttack()


func stopAttack():
	super.stopAttack()
