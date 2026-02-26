extends Area2D

# Using % makes it look for the name anywhere in this scene instance
@onready var spawn_point = get_node_or_null("Spawnpoint") 
var activated := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if activated:
		return

	if body.is_in_group("player"):
		# Check if the node exists BEFORE trying to use it
		if spawn_point:
			body.set_respawn_position(spawn_point.global_position)
			activated = true
			print("Checkpoint at ", global_position, " activated!")
		else:
			# This stops the crash and tells you which one is broken
			print("WARNING: This checkpoint is missing its Spawnpoint child!")
