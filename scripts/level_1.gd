extends Node2D

var zombie_scene = preload("res://scenes/zombie.tscn")
var player_scene = preload("res://scenes/player.tscn")
var overlay_scene = preload("res://scenes/overlay.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var screen_size = get_viewport_rect().size

	for i in 10:
		var zombie = zombie_scene.instantiate()

		zombie.position = Vector2(
			rng.randf_range(50, screen_size.x - 50),
			rng.randf_range(50, screen_size.y - 50)
		)
		add_child(zombie)

	add_child(overlay_scene.instantiate())
	add_child(player_scene.instantiate())
