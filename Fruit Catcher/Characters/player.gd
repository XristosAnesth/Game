extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var dead = false
var deathTimer = 0
var deathTimerReset = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y > 0:
			animated_sprite.animation = "jump"
		else:
			animated_sprite.animation = "fall"
	else:
		if velocity.x == 0:
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "run"

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if dead:
		deathTimer += 1
		if deathTimer > deathTimerReset:
			position = Vector2(0, -57)
			dead = false
			deathTimer = 0
	
	if position.y > 1000:
		position = Vector2(0, -57)


func _on_spikes_body_entered(body):
	dead = true
	velocity.x *=1
	velocity.y += -JUMP_VELOCITY/2
