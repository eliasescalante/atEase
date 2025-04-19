extends Node2D

@onready var sprite = $npc

# Define a dictionary to map numbers to textures
var sprite_textures = [
	preload("res://assets/PJ 5.png"),
	preload("res://assets/PJ (3.png"),
	preload("res://assets/PJ (4.png"),
	preload("res://assets/pj (2).png")
]

func _ready():
	update_sprite(0)

func update_sprite(interpolation: float):
	var npc_state = roundi(interpolation * sprite_textures.size()-1)
	sprite.texture = sprite_textures[npc_state]
