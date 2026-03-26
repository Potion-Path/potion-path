extends CharacterBody2D

@export var speed: float = 80.0
@onready var player: Node2D = $"../PlayerNode"

func _ready() -> void:
	print(player)
	pass

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed

		move_and_slide()
		global_rotation = direction.angle()
		global_position += direction * speed * delta * 2.0

		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
