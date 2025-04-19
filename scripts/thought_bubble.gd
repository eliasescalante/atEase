extends Area2D

signal thought_clicked(was_intrusive: bool)

@export var is_intrusive: bool = true
@export var move_speed: float = 100
@onready var label = $Label

var thought_text: String = ""

func _ready():
	label.text = thought_text
	if is_intrusive:
		label.modulate = Color(1, 0.5, 0.5)
	else:
		label.modulate = Color(0.5, 1, 0.5)

func _process(delta):
	position.y -= move_speed * delta
	if position.y < -50:
		queue_free()

func input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("thought_clicked", is_intrusive)
		queue_free()
