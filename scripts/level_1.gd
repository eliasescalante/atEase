extends Node2D

@onready var bubbles_container = $BubblesContainer
@onready var bubble_scene = preload("res://scenes/bubble.tscn")
@onready var bubble_timer = $BubbleSpawner
@onready var breathing_bar = $BreathingBar
@onready var drain_timer = $BubbleSpawner # <- nuevo timer
@onready var timeLimit_timer = $TimeLimit
@onready var player = $Player

@export var points_bar = 10
@export var points_bar_subtract = 5
@export var points_bar_drain = 2 # <- puntos a restar constantemente

#Breathing Bar
@export var color_good = Color(1, 0, 0, 1)  # Red
@export var color_bad = Color(0, 0, 1, 1)  # Blue

#Bubbles
@export var bubble_max_vel = 600
@export var bubble_min_vel = 80

@export var bubble_timer_min_wait: float = 0.8
@export var bubble_timer_max_wait: float = 3

@export var initial_breathing : float = 50
var current_breathing: float = 0
var interpolation_value: float = 0

var letters = "ASDFJKL"

func _ready():
	timeLimit_timer.timeout.connect(_on_timeLimit_timer_timeout)
	timeLimit_timer.start()
	
	bubble_timer.timeout.connect(_on_bubble_timer_timeout)
	bubble_timer.start()	
	
	drain_timer.timeout.connect(_on_drain_timer_timeout) # <- conectamos
	drain_timer.start() # <- comenzamos el timer
	current_breathing = initial_breathing
	breathing_bar.update_sprite(0.5)

func _process(delta):
	current_breathing = clampf(current_breathing,0,100)
	# Continuously change the color of the target node
	interpolation_value = current_breathing / 100
	player.update_sprite(interpolation_value)
	breathing_bar.update_sprite(interpolation_value)
	

	

func _on_timeLimit_timer_timeout():
	# Trigger scene change when the timer runs out
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")  # TODO Replace next scene


func _on_bubble_timer_timeout():
	var bubble = bubble_scene.instantiate()
	bubble.letter = letters[randi() % letters.length()]
	bubble.speed = lerp(bubble_min_vel, bubble_max_vel, interpolation_value)
	var side_offset = -100 if randf() > 0.5 else 100
	bubble.position = $Player.global_position + Vector2(side_offset, 0)
	bubbles_container.add_child(bubble)
	bubble_timer.start(lerp(bubble_timer_min_wait, bubble_timer_max_wait, interpolation_value))

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		var pressed_letter = char(event.unicode).to_upper()
		for bubble in bubbles_container.get_children():
			if bubble.letter == pressed_letter:
				if abs(bubble.global_position.y - $Player.global_position.y) < 400:
					bubble.queue_free()
					current_breathing -= points_bar
					return
		current_breathing += points_bar_subtract
	current_breathing = clampf(current_breathing,0,100)

func _on_drain_timer_timeout():
	current_breathing += points_bar_drain
	current_breathing = clampf(current_breathing,0,100)
