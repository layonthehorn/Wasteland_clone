extends Control

const RACES = ["Human", "Felilian"]
const GENDERS = ["Male", "Female"]
const AGES = ["20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
"30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"]

const SKILL_COST_DICT = {
1: 2,
2: 4,
3: 6,
4: 10,
5: 14,
6: 18,
7: 24,
8: 30,
9: 36,
10: 44
}
var race:= "Human"
var gender:= "Male"
var age:= "20"
var f_name:= ""
var l_name:= ""
var bio:= ""

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
var skill_dict = {
"automatic weapons": 0, "explosive weapons":0, "energy weapons": 0,
"long weapons": 0, "small weapons": 0, "bladed weapons": 0,
"brawling weapons": 0, "medic": 0, "lock picking": 0,
"doctor": 0, "perception": 0, "bomb disarming": 0,
"safe cracking": 0, "electronics": 0, "mechanical repair": 0,
"confidence": 0, "intimidation": 0, "alarm disarming": 0,
"combat control": 0, "leadership": 0
}

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
onready var bio_entry = $"TabContainer/Info/bioentry"

# attribute bar nodes
onready var str_bar = $"TabContainer/Attributes/attributebars/strengthbar"
onready var int_bar = $"TabContainer/Attributes/attributebars/intelligencebar"
onready var luck_bar = $"TabContainer/Attributes/attributebars/luckbar"
onready var speed_bar = $"TabContainer/Attributes/attributebars/speedbar"
onready var agility_bar = $"TabContainer/Attributes/attributebars/agilitybar"
onready var dexterity_bar = $"TabContainer/Attributes/attributebars/dexteritybar"
onready var charisma_bar = $"TabContainer/Attributes/attributebars/charismabar"

# skill nodes
# bar row one
onready var skill_points_display = $"TabContainer/Skills/skillpoints"
onready var auto_wep_bar = $"TabContainer/Skills/skillbars1/autowepbar"
onready var explos_bar = $"TabContainer/Skills/skillbars1/exploswepbar"
onready var energy_bar = $"TabContainer/Skills/skillbars1/energwepbar"
onready var long_bar = $"TabContainer/Skills/skillbars1/longwepbar"
onready var small_bar = $"TabContainer/Skills/skillbars1/smallwepbar"
onready var blade_bar = $"TabContainer/Skills/skillbars1/bladwepbar"
onready var blunt_bar = $"TabContainer/Skills/skillbars1/blunwepbar"

# bar row two
onready var brawl_bar = $"TabContainer/Skills/skillbars2/brawlwepbar"
onready var medic_bar = $"TabContainer/Skills/skillbars2/medicbar"
onready var doctor_bar = $"TabContainer/Skills/skillbars2/doctorbar"
onready var perception_bar = $"TabContainer/Skills/skillbars2/perceptionbar"
onready var lock_bar = $"TabContainer/Skills/skillbars2/lockpickbar"
onready var bomb_bar = $"TabContainer/Skills/skillbars2/bombdisbar"
onready var safe_bar = $"TabContainer/Skills/skillbars2/safecrackbar"

# bar row three
onready var elec_bar = $"TabContainer/Skills/skillbars3/electronicsbar"
onready var mech_bar =$"TabContainer/Skills/skillbars3/mechanicbar"
onready var con_bar = $"TabContainer/Skills/skillbars3/confidencebar"
onready var intim_bar = $"TabContainer/Skills/skillbars3/intimidatebar"
onready var alarm_bar = $"TabContainer/Skills/skillbars3/alarmdisbar"
onready var com_ctr = $"TabContainer/Skills/skillbars3/combatconbar"
onready var lead_bar = $"TabContainer/Skills/skillbars3/leadershipbar"

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

func _on_bioentry_text_changed():
	bio = bio_entry.text

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

func update_stat_bar_fill(stat):
		match stat:
			"strength":
				update_bar(str_bar, stat)
			"intelligence":
				update_bar(int_bar, stat)
			"luck":
				update_bar(luck_bar, stat)
			"speed":
				update_bar(speed_bar, stat)
			"agility":
				update_bar(agility_bar, stat)
			"dexterity":
				update_bar(dexterity_bar, stat)
			"charisma":
				update_bar(charisma_bar, stat)

func increase_stat(stat):
	if total_stat_points > 0 and stat_dict[stat] < 10:
		total_stat_points -= 1
		stat_dict[stat] += 1
		update_stat_points()
		update_stat_bar_fill(stat)

func decrease_stat(stat):
	if stat_dict[stat] > 1:
		total_stat_points += 1
		stat_dict[stat] -= 1
		update_stat_points()
		update_stat_bar_fill(stat)

func update_stat_points():
	att_point_display.text = str(total_stat_points) + " left"

# skill tab actions
func increase_skill(skill):
	var current_skill_level = skill_dict[skill]
	if total_stat_points >= SKILL_COST_DICT[current_skill_level +1 ]:
		if current_skill_level < 10:
			pass

func decrease_skill(skill):
	var current_skill_level = skill_dict[skill]
	if current_skill_level > 1:
		total_skill_points += SKILL_COST_DICT[current_skill_level]
		skill_dict[skill] -= 1
