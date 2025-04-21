extends TextureRect
# Define a dictionary to map numbers to textures
var sprite_textures = [
	preload("res://assets/breathing1.png"),
	preload("res://assets/breathing2.png"),
	preload("res://assets/breathing3.png"),
	preload("res://assets/breathing4.png"),
	preload("res://assets/breathing5.png"),
	preload("res://assets/breathing6.png"),
	preload("res://assets/breathing7.png"),
	preload("res://assets/breathing8.png"),
	preload("res://assets/breathing9.png"),
	preload("res://assets/breathing10.png")
]

func _ready():
	update_sprite(0)

func update_sprite(interpolation: float):
	var npc_state = roundi(interpolation * (sprite_textures.size()-1))
	print(npc_state)
	texture = sprite_textures[npc_state]
