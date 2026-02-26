extends Area2D

@onready var dialogue_label = $Label # Reference to the label above head

# Simple Dialogue Data
var text_start = "Kan du finne ingredisen min? Jeg trenger den for min legendariske potion!"
var text_waiting = "Fort deg da din grunt."
var text_complete = "Wow! Du fant den! Men jeg trenger 2 mere.."	

# Track if the quest is finished so we don't repeat the reward
var quest_completed = false

func _ready():
	# Ensure the label is hidden at start
	dialogue_label.visible = false
	# Connect the click signal
	input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		advance_quest_dialogue()

func advance_quest_dialogue():
	dialogue_label.visible = true

	if quest_completed:
		dialogue_label.text = text_complete
	elif GameManager.has_quest_item:
		# Player has returned with the item!
		dialogue_label.text = text_complete
		quest_completed = true
		# (Optional) Give player gold/xp here
		
	else:
		# Quest hasn't started or item not found yet
		if dialogue_label.text == text_start:
			 # If they click again, remind them
			dialogue_label.text = text_waiting
		else:
			dialogue_label.text = text_start
