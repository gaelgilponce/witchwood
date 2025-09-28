extends CharacterBody2D

@export var move_speed: float = 250.0
@export var jump_speed: float = 600.0

@onready var animated_sprite = $AnimatedSprite2D

var is_attacking

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	jump(delta)
	move_x()
	flip()
	update_animation()
	move_and_slide()

func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("Jump")
		#else:
			#animated_sprite.play("Fall")
	elif velocity.x != 0:
		animated_sprite.play("Walk")
	elif Input.is_action_just_pressed("Hability") and is_on_floor():
		print("Attacck!!!!!")
		animated_sprite.play("Shoot")
	else:
		animated_sprite.play("Idle")

func jump(delta):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_speed
	elif not is_on_floor():
		velocity.y += gravity * delta

func flip():
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

func move_x():
	var input_axis = Input.get_axis("Left", "Right")
	velocity.x = input_axis * move_speed
