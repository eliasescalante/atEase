extends Area2D

signal thought_clicked(was_intrusive: bool)

@export var is_intrusive: bool = true
@export var move_speed: float = 100
@onready var label = $Label
@onready var bubble = $bubble

@export var intrusive_text_color : Color
@export var intrusive_bubble_color : Color
@export var positive_text_color : Color
@export var positive_bubble_color : Color

var thought_text: String = ""

func _ready():
	label.text = thought_text
	if is_intrusive:
		label.modulate = intrusive_text_color
		bubble.modulate = intrusive_bubble_color
	else:
		label.modulate = positive_text_color
		bubble.modulate = positive_bubble_color

func _process(delta):
	position.y -= move_speed * delta
	if position.y < -50:
		queue_free()

func input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("thought_clicked", is_intrusive)
		queue_free()
