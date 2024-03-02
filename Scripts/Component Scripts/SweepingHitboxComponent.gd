class_name SweepingHitboxComponent
extends HitboxComponent
## This component handles a sweeping or dynamic hitbox
##
## This is a more complex child of the HitboxComponent
## that also accepts a reference to an AnimationPlayer
## that should move the position/rotation of this
## hitbox's area2D.

## A reference to the AnimationPlayer with this sweeping hitbox's sweep animation.
@export
var sweepAnimation: AnimationPlayer

## The name of the sweep animation.
@export
var animationName: String

## Begin Attack
func startAttack():
	super.startAttack()
	
	# Playing the sweeping animation. (Should move the hitbox area).
	sweepAnimation.play(animationName)
	
	# Waiting for animation to end to finish attack.
	await sweepAnimation.animation_finished
	
	# Resetting state.
	sweepAnimation.play("RESET")
	stopAttack()

## End Attack
func stopAttack():
	super.stopAttack()
