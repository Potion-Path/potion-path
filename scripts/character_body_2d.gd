extends CharacterBody2D

var speed = 300
var jump_velocity = -700
var gravity = 1500
var stamina = 100

@export var stamina_bar: ProgressBar

func _ready():
	stamina_bar.max_value = 100
	stamina_bar.value = stamina
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	var is_sprinting = Input.is_key_pressed(KEY_SHIFT) and stamina > 10

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		stamina = min(stamina + 15 * delta, 100)

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = lerp(-200, -700, stamina / 100)
		
		stamina = max(stamina - 5, 0)

	stamina_bar.value = stamina

	var direction = 0
	if Input.is_key_pressed(KEY_D):
		direction += 1
	if Input.is_key_pressed(KEY_A):
		direction -= 1

	if direction != 0 and Input.is_key_pressed(KEY_SHIFT):
		if is_sprinting:
			velocity.x = direction * 600
		else:
			velocity.x = direction * 300

		stamina = max(stamina - 2, 0)
	elif direction != 0:
		velocity.x = direction * 300
	else:
		velocity.x = 0

	move_and_slide()

	if direction != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	if direction < 0:
		$AnimatedSprite2D.flip_h = false
	elif direction > 0:
		$AnimatedSprite2D.flip_h = true
