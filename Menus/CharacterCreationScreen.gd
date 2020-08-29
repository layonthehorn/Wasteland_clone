extends Node

onready var squad_one = $"SquadOne"
onready var squad_two = $"SquadTwo"
onready var squad_three = $"SquadThree"
onready var squad_four = $"SquadFour"


func _on_ToSquadTwo_pressed():
	squad_one.visible = false
	squad_two.visible = true
	squad_three.visible = false
	squad_four.visible = false

func _on_ToSquadOne_pressed():
	squad_one.visible = true
	squad_two.visible = false
	squad_three.visible = false
	squad_four.visible = false


func _on_ToSquadThree_pressed():
	squad_one.visible = false
	squad_two.visible = false
	squad_three.visible = true
	squad_four.visible = false


func _on_ToSquadFour_pressed():
	squad_one.visible = false
	squad_two.visible = false
	squad_three.visible = false
	squad_four.visible = true
