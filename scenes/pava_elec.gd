extends Area2D

signal object_clicked()

func input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("object_clicked")
		queue_free()
