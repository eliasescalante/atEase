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
	
