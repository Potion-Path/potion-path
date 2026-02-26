extends Area2D

func _ready():
	# Connect the input_event signal to detect clicks
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	# Check if the event is a left mouse button click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		pick_up_item()

func pick_up_item():
	print("Item picked up!")
	GameManager.has_quest_item = true # Update the global state
	queue_free() # Remove the item from the game
