extends Node2D

@onready var sprite = $npc

# Define a dictionary to map numbers to textures
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
	# Ajustamos la lógica de interpolación para invertir el efecto de respiración
	var npc_state = roundi((1.0 - interpolation) * (sprite_textures.size() - 1))
	
	# Verificamos si el estado ha cambiado y reproducimos el audio correspondiente
	if npc_state != last_state:
		if npc_state > last_state:
			AudioManager.play_respiracion_calmada()  # Reproducir respiración calmada cuando la respiración baja
			AudioManager.stop_respiracion_rapida()   # Detener respiración rápida
		elif npc_state < last_state:
			AudioManager.play_respiracion_rapida()   # Reproducir respiración rápida cuando la respiración sube
			AudioManager.stop_respiracion_calmada()  # Detener respiración calmada
		last_state = npc_state
		npc_state = roundi((interpolation) * (sprite_textures.size() - 1))
	sprite.texture = sprite_textures[npc_state]
