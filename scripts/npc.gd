extends Area2D

@onready var dialogue_label = $Label
@onready var hide_timer = $HideTimer 

var text_start = "Hei! Jeg mistet edelstenen min. Kan du finne den?"
var text_waiting = "Vær så snill å skynd deg! Jeg trenger den edelstenen."
var text_complete = "Du fant den! Du er en helt!"

var quest_completed = false
var dialogue_tween: Tween

var base_bottom_y: float

func _ready():
	base_bottom_y = dialogue_label.position.y + dialogue_label.size.y
	dialogue_label.visible = false	
	
	# Kobler til signalene via kode
	input_event.connect(_on_input_event)
	hide_timer.timeout.connect(_on_hide_timer_timeout)

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		advance_quest_dialogue()

func advance_quest_dialogue():
	dialogue_label.visible = true
	
	# 1. Start (eller restart) 8-sekunders timeren
	hide_timer.start()
	
	# 2. Finn ut hvilken tekst som skal vises basert på oppdragets status
	var new_text = ""
	if quest_completed:
		new_text = text_complete
	elif GameManager.has_quest_item:
		new_text = text_complete
		quest_completed = true
	else:
		if dialogue_label.text == text_start:
			new_text = text_waiting
		else:
			new_text = text_start
			
	# Sett inn den nye teksten
	dialogue_label.text = new_text
	
	# 3. Juster størrelsen på tekstboksen automatisk (Oppdatert for å fjerne tomrom)
	dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	dialogue_label.custom_minimum_size.x = 150
	await get_tree().process_frame
	
	
	
	# Tvinger høyden til å kollapse slik at den spretter opp igjen til helt perfekt størrelse
	dialogue_label.custom_minimum_size.y = 0 
	dialogue_label.size.y = 0
	
	await get_tree().process_frame
	dialogue_label.position.y = base_bottom_y - dialogue_label.size.y
	
	
	# 4. Skrivemaskin-effekten
	dialogue_label.visible_ratio = 0.0
	
	if dialogue_tween:
		dialogue_tween.kill() # Stopper forrige animasjon hvis spilleren klikker raskt
		
	dialogue_tween = create_tween()
	dialogue_tween.tween_property(dialogue_label, "visible_ratio", 1.0, 1.5)

# 5. Skjul teksten når timeren går ut
func _on_hide_timer_timeout():
	dialogue_label.visible = false
