extends Node

@export_category("References")
@export_group("Music")
@export var music_loop : AudioStreamPlayer

@export_group("SFX")
@export var barullo_loop: AudioStreamPlayer
@export var respiracion_calmada: AudioStreamPlayer
@export var respiracion_rapida: AudioStreamPlayer
@export var poof_sfx: AudioStreamPlayer # Sonido para dar inicio a los minijuegos
@export var interactions_A: AudioStreamPlayer
@export var interactions_B: AudioStreamPlayer


func play_interaction():
	$SFX/InteractionsB.play()
func play_interactionB():
	$SFX/InteractionsA.play()
func play_respiracion_calmada():
	$SFX/RespiracionCalmada.play()
func play_respiracion_rapida():
	$SFX/RespiraacionRapida
