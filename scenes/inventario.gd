extends Node2D

var pava
var mate
var yerba
var azucarera

func _ready():
	pava= $PavaElec
	mate= $Mate
	yerba= $Yerba
	azucarera= $Azucarera

func addPavaToInventory():
	pava.visible = true

func addMateToInventory():
	mate.visible = true
	
func addYerbaToInventory():
	yerba.visible = true
	
func addAzucareraToInventory():
	azucarera.visible = true

func get_total_items() -> int:
	var total = 0
	if pava.visible:
		total += 1
	if mate.visible:
		total += 1
	if yerba.visible:
		total += 1
	if azucarera.visible:
		total += 1
	return total
