extends Node

@export_file("*.tscn") var next_scene_path: String

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file(next_scene_path)
