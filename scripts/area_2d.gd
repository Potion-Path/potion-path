extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)

	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position:y", position.y - 50, 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y, 1.0).set_trans(Tween.TRANS_SINE)

func _on_body_entered(_body: Node2D):
	#$"../CanvasLayer/Inventory".add_item("potion")
	queue_free()
