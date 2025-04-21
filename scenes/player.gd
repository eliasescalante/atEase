extends Node2D

@onready var sprite = $npc

var sprite_textures = [
	preload("res://assets/PJ 5.png"),      # Calmado
	preload("res://assets/PJ (3.png"),     # Menos calmado
	preload("res://assets/PJ (4.png"),     # agitado
	preload("res://assets/pj (2).png")     # mal agitadisimo
]

var last_state := 0

func _ready():
	update_sprite(0)

func update_sprite(interpolation: float):
	#inverti la logica asi me pega la respiracion
	var npc_state = roundi((1.0 - interpolation) * (sprite_textures.size() - 1))
	
	if npc_state != last_state:
		if npc_state > last_state:
			AudioManager.play_respiracion_calmada()
			AudioManager.stop_respiracion_rapida()
		elif npc_state < last_state:
			AudioManager.play_respiracion_rapida()
			AudioManager.stop_respiracion_calmada()
		last_state = npc_state
		npc_state = roundi((interpolation) * (sprite_textures.size() - 1))
	sprite.texture = sprite_textures[npc_state]
