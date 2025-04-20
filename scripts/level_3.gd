extends Node2D

@onready var thoughts_container = $ThoughtsContainer
@onready var thought_scene = preload("res://scenes/thought_bubble.tscn")
@onready var breathing_bar = $BreathingBar
@onready var inventario = $Inventario
@onready var drain_timer = $DrainTimer
@onready var time_limit = $TimeLimit

@export var points_bar = 10
@export var points_bar_subtract = 5
@export var points_bar_drain = 2

#Breathing Bar
@export var initial_breathing : float = 50
var current_breathing: float = 0
var interpolation_value: float = 0


func _ready():
	time_limit.timeout.connect(_on_time_limit_timeout)
	time_limit.start()


func _on_pava_clicked():
	inventario.addPavaToInventory()
	
func _on_azucarera_clicked():
	inventario.addAzucareraToInventory()
	
func _on_yerba_clicked():
	inventario.addYerbaToInventory()
	
func _on_mate_clicked():
	inventario.addMateToInventory()


func _on_time_limit_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")  # Cambiá por la siguiente escena pero como no esta todavia lo deje en main
