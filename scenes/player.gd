extends Node2D

@onready var sprite = $npc


# Define a dictionary to map numbers to textures
var sprite_textures = [
	preload("res://assets/PJ 5.png"),
	preload("res://assets/PJ (3.png"),
	preload("res://assets/PJ (4.png"),
	preload("res://assets/pj (2).png")
]

var last_state := 0

func _ready():
	update_sprite(0)

func update_sprite(interpolation: float):
	var npc_state = roundi(interpolation * (sprite_textures.size()-1))
	
	if npc_state != last_state:
		if npc_state > last_state:
			AudioManager.play_respiracion_calmada()
		elif npc_state < last_state:
			AudioManager.play_respiracion_rapida()
		last_state = npc_state
		
	sprite.texture = sprite_textures[npc_state]
