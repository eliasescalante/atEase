extends Node2D

@onready var thoughts_container = $ThoughtsContainer
@onready var thought_scene = preload("res://scenes/thought_bubble.tscn")
@onready var breathing_bar = $BreathingBar
@onready var spawner_timer = $ThoughtSpawner
@onready var drain_timer = $DrainTimer
@onready var time_limit = $TimeLimit
@onready var audio_manager = $AudioManager



@export var points_bar = 10
@export var points_bar_subtract = 5
@export var points_bar_drain = 2

#Breathing Bar
@export var initial_breathing : float = 50
var current_breathing: float = 0
var interpolation_value: float = 0

@export var intrusive_thoughts = [
	"No puedo respirar", 
	"Esto no va a pasar", 
	"Estoy perdiendo el control", 
	"Me voy a desmayar"
]

@export var positive_thoughts = [
	"Va a pasar", 
	"No estás solo", 
	"Es solo un momento", 
	"Podés con esto"
]

func _ready():
	time_limit.timeout.connect(_on_time_limit_timeout)
	time_limit.start()

	spawner_timer.timeout.connect(_on_spawner_timeout)
	spawner_timer.start()

	drain_timer.timeout.connect(_on_drain_timeout)
	drain_timer.start()
	current_breathing = initial_breathing
	breathing_bar.update_sprite(0.5)

func _process(delta):
	current_breathing = clampf(current_breathing,0,100)
	interpolation_value = current_breathing / 100
	breathing_bar.update_sprite(interpolation_value)

func _on_spawner_timeout():
	var thought = thought_scene.instantiate()
	var is_intrusive = randf() > 0.5
	thought.is_intrusive = is_intrusive
	thought.thought_text = intrusive_thoughts.pick_random() if is_intrusive else positive_thoughts.pick_random()


	var screen_size = get_viewport_rect().size
	var x_pos = randf_range(100, screen_size.x - 100)
	var y_pos = screen_size.y + 30
	thought.position = Vector2(x_pos, y_pos)

	thought.thought_clicked.connect(_on_thought_clicked)
	thoughts_container.add_child(thought)

func _on_thought_clicked(was_intrusive: bool):
	if was_intrusive:
		current_breathing = clampf(current_breathing - points_bar,0,100)
	else:
		current_breathing = clampf(current_breathing + points_bar_subtract,0,100)
		AudioManager.play_interactionB()
func _on_drain_timeout():
	current_breathing = clampf(current_breathing + points_bar_drain, 0 ,100)

func _on_time_limit_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")  # Cambiá por la siguiente escena pero como no esta todavia lo deje en main
