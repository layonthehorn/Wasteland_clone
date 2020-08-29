extends Node


onready var squad_one = $"SquadOne"
onready var squad_two = $"SquadTwo"
onready var squad_three = $"SquadThree"
onready var squad_four = $"SquadFour"
onready var squad_storage = SquadSingleton
onready var squad = [squad_one, squad_two, squad_three, squad_four]

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


func _on_Finished_pressed():
	var count = 0
	for member in squad:
		squad_storage.squad_list[count].f_name = member.f_name
		squad_storage.squad_list[count].l_name = member.l_name
		squad_storage.squad_list[count].age = member.age
		squad_storage.squad_list[count].bio = member.bio
		squad_storage.squad_list[count].race = member.race
		squad_storage.squad_list[count].gender = member.gender
		squad_storage.squad_list[count].skill_dict = member.skill_dict
		squad_storage.squad_list[count].stat_dict = member.stat_dict
		squad_storage.squad_list[count].update_max_health()
		count += 1
		
	for member in SquadSingleton.squad_list:
			print(member.f_name)
			print(member.l_name)
			print(member.age)
			print(member.age)
			print(member.gender)
			print(member.race)
			print("")

