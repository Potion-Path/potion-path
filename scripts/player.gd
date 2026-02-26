extends CharacterBody2D

var speed = 300
var jump_velocity = -700
var gravity = 1500
var stamina = 100

var respawn_position : Vector2

@onready var stamina_bar: ProgressBar = $"../CanvasLayer/ProgressBar"

func _ready():
	stamina_bar.max_value = 100
	stamina_bar.value = stamina
	$AnimatedSprite2D.play("idle")
	respawn_position = global_position 

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

	var direction = Input.get_axis("ui_left", "ui_right")
	# Using your specific keys from previous code
	if Input.is_key_pressed(KEY_D): direction = 1
	if Input.is_key_pressed(KEY_A): direction = -1

	if direction != 0:
		velocity.x = direction * (600 if is_sprinting else 300)
		if is_sprinting: stamina = max(stamina - 2, 0)
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = (direction > 0)
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("idle")

	move_and_slide()

func set_respawn_position(new_pos: Vector2):
	respawn_position = new_pos
	print("New Respawn Set!")

func die():
	global_position = respawn_position
	velocity = Vector2.ZERO
