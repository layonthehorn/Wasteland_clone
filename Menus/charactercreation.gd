extends Control

const RACES = ["Human", "Felilian"]
const GENDERS = ["Male", "Female"]
const AGES = ["20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
"30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"]

var race:= "Human"
var gender:= "Male"
var age:= "20"
var f_name:= ""
var l_name:= ""

# attribute handling variables
var total_stat_points:= 7 + 14
var stat_dict = {"strength": 1,
				 "intelligence": 1,
				 "luck": 1,
				 "speed": 1,
				 "agility": 1,
				 "dexterity": 1,
				 "charisma": 1}

# skill point handling variables
var total_skill_points:= 12

func update_stat_points():
	att_point_display.text = str(total_stat_points) + " left"

func _ready():
	update_stat_points()
	for species in RACES:
		race_select.add_item(species)
	for gend in GENDERS:
		gender_select.add_item(gend)
	for ages in AGES:
		age_select.add_item(ages)
		

# Character information nodes
onready var att_point_display = $"TabContainer/Attributes/points"
onready var race_select = $"TabContainer/Info/infobox/raceselect"
onready var gender_select = $"TabContainer/Info/infobox/genderselect"
onready var age_select = $"TabContainer/Info/infobox/ageselect"

# attribute bar nodes
onready var str_bar = $"TabContainer/Attributes/attributebars/strengthbar"
onready var int_bar = $"TabContainer/Attributes/attributebars/intelligencebar"
onready var luck_bar = $"TabContainer/Attributes/attributebars/luckbar"
onready var speed_bar = $"TabContainer/Attributes/attributebars/speedbar"
onready var agility_bar = $"TabContainer/Attributes/attributebars/agilitybar"
onready var dexterity_bar = $"TabContainer/Attributes/attributebars/dexteritybar"
onready var charisma_bar = $"TabContainer/Attributes/attributebars/charismabar"


func update_bar(bar, stat):
	bar.value = stat_dict[stat] 

# all info tab functions
func _on_raceselect_item_selected(index):
	race = RACES[index]

func _on_genderselect_item_selected(index):
	gender = GENDERS[index]


func _on_ageselect_item_selected(index):
	age = AGES[index]

func _on_firstnameentry_text_changed(new_text):
	f_name = new_text

func _on_lastnameentry_text_changed(new_text):
	l_name = new_text

func increase_stat(stat):
	if total_stat_points > 0 and stat_dict[stat] < 10:
		total_stat_points -= 1
		stat_dict[stat] += 1
		update_stat_points()
		match stat:
			"strength":
				update_bar(str_bar,"strength")
			"intelligence":
				update_bar(int_bar, "intelligence")
			"luck":
				update_bar(luck_bar, "luck")
			"speed":
				update_bar(speed_bar, "speed")
			"agility":
				update_bar(agility_bar, "agility")
			"dexterity":
				update_bar(dexterity_bar, "dexterity")
			"charisma":
				update_bar(charisma_bar, "charisma")


func decrease_stat(stat):
	if stat_dict[stat] > 1:
		total_stat_points += 1
		stat_dict[stat] -= 1
		update_stat_points()
		match stat:
			"strength":
				update_bar(str_bar,"strength")
			"intelligence":
				update_bar(int_bar, "intelligence")
			"luck":
				update_bar(luck_bar, "luck")
			"speed":
				update_bar(speed_bar, "speed")
			"agility":
				update_bar(agility_bar, "agility")
			"dexterity":
				update_bar(dexterity_bar, "dexterity")
			"charisma":
				update_bar(charisma_bar, "charisma")
# all Attribute tab functions
func _on_strengthup_pressed():
	increase_stat("strength")

func _on_strengthdown_pressed():
	decrease_stat("strength")

func _on_intelligenceup_pressed():
	increase_stat("intelligence")

func _on_intelligencedown_pressed():
	decrease_stat("intelligence")

func _on_luckup_pressed():
	increase_stat("luck")

func _on_luckdown_pressed():
	decrease_stat("luck")

func _on_speedup_pressed():
	increase_stat("speed")

func _on_speeddown_pressed():
	decrease_stat("speed")

func _on_agilityup_pressed():
	increase_stat("agility")

func _on_agilitydown_pressed():
	decrease_stat("agility")

func _on_dexterityup_pressed():
	increase_stat("dexterity")

func _on_dexteritydown_pressed():
	decrease_stat("dexterity")

func _on_charismaup_pressed():
	increase_stat("charisma")

func _on_charismadown_pressed():
	decrease_stat("charisma")

# skill tab actions
