extends Node2D

@export var letter := "A"
@export var speed := 80

func _ready():
	$Label.text = letter

func _process(delta):
	position.y -= speed * delta
	if position.y < -50:
		queue_free()
