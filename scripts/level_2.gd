extends Node2D

@onready var thoughts_container = $ThoughtsContainer
@onready var thought_scene = preload("res://scenes/thought_bubble.tscn")
@onready var respiration_bar = $RespirationBar
@onready var spawner_timer = $ThoughtSpawner
@onready var drain_timer = $DrainTimer
@onready var time_limit = $TimeLimit

@export var points_bar = 10
@export var points_bar_subtract = 5
@export var points_bar_drain = 2

#Breathing Bar
@export var color_good = Color(1, 0, 0, 1)  # Red
@export var color_bad = Color(0, 0, 1, 1)  # Blue

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

func _process(delta):
	var interp = respiration_bar.value / respiration_bar.max_value
	respiration_bar.modulate = lerp(color_good, color_bad, interp)

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
		respiration_bar.value = max(0, respiration_bar.value - points_bar)
	else:
		respiration_bar.value = min(respiration_bar.max_value, respiration_bar.value + points_bar_subtract)

func _on_drain_timeout():
	respiration_bar.value = min(respiration_bar.max_value, respiration_bar.value + points_bar_drain)

func _on_time_limit_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")  # Cambiá por la siguiente escena pero como no esta todavia lo deje en main
