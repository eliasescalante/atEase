extends Node2D

@onready var bubbles_container = $BubblesContainer
@onready var bubble_scene = preload("res://scenes/bubble.tscn")
@onready var bubble_timer = $BubbleSpawner
@onready var respiration_bar = $RespirationBar
@onready var drain_timer = $BubbleSpawner # <- nuevo timer

@export var points_bar = 10
@export var points_bar_subtract = 5
@export var points_bar_drain = 2 # <- puntos a restar constantemente

var letters = "ASDFJKLÑ"

func _ready():
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)
	bubble_timer.start()

	drain_timer.timeout.connect(_on_drain_timer_timeout) # <- conectamos
	drain_timer.start() # <- comenzamos el timer

func _on_bubble_timer_timeout():
	var bubble = bubble_scene.instantiate()
	bubble.letter = letters[randi() % letters.length()]
	var side_offset = -100 if randf() > 0.5 else 100
	bubble.position = $Player.global_position + Vector2(side_offset, 0)
	bubbles_container.add_child(bubble)

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		var pressed_letter = char(event.unicode).to_upper()
		for bubble in bubbles_container.get_children():
			if bubble.letter == pressed_letter and abs(bubble.global_position.y - $Player.global_position.y) < 50:
				bubble.queue_free()
				respiration_bar.value += points_bar
				return
		respiration_bar.value -= points_bar_subtract

func _on_drain_timer_timeout():
	respiration_bar.value -= points_bar_drain
