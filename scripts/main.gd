extends Node2D


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_1.tscn")
	
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	
func _on_credits_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
