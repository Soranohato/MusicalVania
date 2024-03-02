# Introduction:

Note: This is a markdown file, which for some reason Godot does not format. I'd suggest you open this file using VS Code or some other md viewer as that would make life easier...
If you know a Godot Addon that allows the editor to view mark down files please lmk

Welcome Programmer! This section is designed to be a rough introduction to how we are structuring the overall code for the game, and will also contain a list of tasks to be completed.

### Commonly Used Links:

- [Todo's](#todos)
- [Active Bugs](#active-bugs)
- [Communications](#communications)

## Composition:

### What is Composition?

This youtube video highlights composition pretty well: <br>
<strong>https://youtu.be/74y6zWZfQKk?si=okXYXt2k9iWiqKAH</strong>

<br>

As for a summary, Composition is based off of components.

Suppose you wanted to create a Player. This Player is going to need <b>"Attack"</b>, <b>"Health"</b>, <b>"Move"</b> and <b>"TakeInput"</b>. Likewise, an Enemy would have to do the same things, except instead of <b>"TakeInput"</b>, it would need to do <b>"AI_Stuff"</b>.

If we were doing inheritance, we could create a super class Entity to handle <b>"Attack"</b>, <b>"Health"</b> and <b>"Move"</b> with the Player and Enemy classes inheriting from Entity.

The big problem comes when we introduce say a Tree, with just <b>"Health"</b>. Ideally we would like to reuse our code from Entity, but that would require re structuring our inheritance structure.

Components on the other hand, are pieces of code that handle a single function. Godot is effectively built on components and inheritence (think Area2D that handles all collision implementation). So now, we can make components to handle each functionality, and simply add the respective components to our Player, Enemy and Tree.

Note: You can also use inheritance alongside components. For example, The CharacterBody2D Node and RigidBody2D Node inherits the PhysicsBody2D Node.

### How To Components

The way we are currently implementing components is by making a scene. If you want to add say a gravity component, you first make a new scene in the <u><i>Scenes/Components</i></u> folder. Be sure to name it appropriately (See the other components for reference).

The root of the scene may vary based on necessity, for example the HurtboxComponent has a root node of an Area2D as the component is effectively a collision box for handling taking damage.

For the gravity node, lets make the root a Node2D.

Now we attach a script, with the component script located in <u><i>Scripts/Component Scripts</i></u>

Below is a sample code:

```gdscript
	extends Node2D
	class_name GravityComponent

	@export
	var parent: CharacterBody2D

	@export
	var gravity: float

	@export
	var airFriction: float = 0.6

	func _physics_process(delta):
		if parent.is_on_floor():
			return

		if parent.velocity.y>0:
			parent.velocity.y += gravity*airFriction*delta
		else:
			parent.velocity.y += gravity*delta

The export variables here are variables whose values will be initialized during run-time and can be changed through the editor. If a component requires a reference to another component, It is advised to make that an export variable, so that the value of the reference can be changed and edited based off of the situation.

Also, try to make the references as generic as possible. For example, Instead of having the parent always be a CharacterBody2D, there may be situations where we want the same component to be applied to a RigidBody2D, for example the HealthComponent.

<b>Please keep in mind that components should be as modular as possible.</b>

## Terminology

Here's a list of terminology we are using in the code:

- <b>Hitbox</b>: An Area2D that handles dealing damage.
- <b>Hurtbox</b>: An Area2D that checks wether a Hitbox is present and handles taking damage.
- <b>Collision Box</b>: An Area2D that handles physics collisions.

# Organization

## TODOS

If you feel like programming but aren't sure what to work on, feel free to choose one of the following or add one of your own:

- [_] <b>Heavy Attack</b>
- [_] <b>Medium Attack</b>
- [_] <b>State Machine</b>: Advait
- [_] <b>Enemy</b>
- [_] <b>Projectiles</b>
- [_] <b>Animation Implementation</b>
- [X] <b>Health Component</b>
- [X] <b>Gravity Component</b>

## Active Bugs:

List of Bugs to fix:

- [_] <b>Test Dummy is not affected by gravity</b>: For some reason, the test dummy thinks its on the floor when it isn't

## Communications:

<b>Advait</b> - If you would like to add some Messages / Notes for future programmers, feel free to add it here!
