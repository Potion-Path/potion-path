extends CharacterBody2D

var speed = 200
var jump_velocity = -400
var gravity = 980

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = jump_velocity

	var direction = 0
	if Input.is_key_pressed(KEY_D):
		direction += 1
	if Input.is_key_pressed(KEY_A):
		direction -= 1

	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	
	move_and_slide()
