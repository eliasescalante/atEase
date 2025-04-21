extends Node2D

@onready var sprite = $npc

var sprite_textures = [
	preload("res://assets/PJ 5.png"),      # Calmado (index 0)
	preload("res://assets/PJ (3.png"),     # Menos calmado
	preload("res://assets/PJ (4.png"),     # Agitado
	preload("res://assets/pj (2).png")     # Muy agitado
]

var last_state := 0

func _ready():
	update_sprite(0)

func update_sprite(interpolation: float):
	var new_state = roundi(interpolation * (sprite_textures.size() - 1))

	if new_state > last_state:
		# Va subiendo -> usar el estado siguiente
		last_state = new_state
		sprite.texture = sprite_textures[last_state]
		AudioManager.play_respiracion_rapida()
		AudioManager.stop_respiracion_calmada()
	elif new_state < last_state:
		# Si baja, volvemos al calmado (índice 0)
		last_state = 0
		sprite.texture = sprite_textures[0]
		AudioManager.play_respiracion_calmada()
		AudioManager.stop_respiracion_rapida()
