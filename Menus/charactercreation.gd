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
"combat control": 0, "leadership": 0, "blunt weapons": 0
}

func _ready():
	update_stat_points()
	update_skill_display()
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
onready var com_ctr_bar = $"TabContainer/Skills/skillbars3/combatconbar"
onready var lead_bar = $"TabContainer/Skills/skillbars3/leadershipbar"

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
func update_bar(bar, stat):
	bar.value = stat_dict[stat] 

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
func update_skill_bar(bar, stat):
	bar.value = skill_dict[stat] 

func update_skill_bar_fill(skill):
		match skill:
			"automatic weapons":
				update_skill_bar(auto_wep_bar, skill)
			"explosive weapons":
				update_skill_bar(explos_bar, skill)
			"energy weapons":
				update_skill_bar(energy_bar, skill)
			"long weapons":
				update_skill_bar(long_bar, skill)
			"small weapons":
				update_skill_bar(small_bar, skill)
			"bladed weapons":
				update_skill_bar(blade_bar, skill)
			"blunt weapons":
				update_skill_bar(blunt_bar, skill)
			"brawling weapons":
				update_skill_bar(brawl_bar, skill)
			"medic":
				update_skill_bar(medic_bar, skill)
			"lock picking":
				update_skill_bar(lock_bar, skill)
			"doctor":
				update_skill_bar(doctor_bar, skill)
			"perception":
				update_skill_bar(perception_bar, skill)
			"bomb disarming":
				update_skill_bar(bomb_bar, skill)
			"safe cracking":
				update_skill_bar(safe_bar, skill)
			"electronics":
				update_skill_bar(elec_bar, skill)
			"mechanical repair":
				update_skill_bar(mech_bar, skill)
			"confidence":
				update_skill_bar(con_bar, skill)
			"intimidation":
				update_skill_bar(intim_bar, skill)
			"alarm disarming":
				update_skill_bar(alarm_bar, skill)
			"combat control":
				update_skill_bar(com_ctr_bar, skill)
			"leadership":
				update_skill_bar(lead_bar, skill)

func update_skill_display():
	skill_points_display.text = str(total_skill_points) + " left"

func increase_skill(skill):
	var current_skill_level = skill_dict[skill]
	if current_skill_level < 10:
		if total_skill_points >= SKILL_COST_DICT[current_skill_level + 1]:
			total_skill_points -= SKILL_COST_DICT[current_skill_level + 1]
			skill_dict[skill] += 1
			update_skill_bar_fill(skill)
			update_skill_display()

func decrease_skill(skill):
	var current_skill_level = skill_dict[skill]
	if current_skill_level > 0:
		total_skill_points += SKILL_COST_DICT[current_skill_level]
		skill_dict[skill] -= 1
		update_skill_bar_fill(skill)
		update_skill_display()

# row one buttons
func _on_autowepup_pressed():
	increase_skill("automatic weapons")

func _on_autowepdown_pressed():
	decrease_skill("automatic weapons")

func _on_explodwepup_pressed():
	increase_skill("explosive weapons")

func _on_explodwepdown_pressed():
	decrease_skill("explosive weapons")

func _on_energwepup_pressed():
	increase_skill("energy weapons")

func _on_energwepdown_pressed():
	decrease_skill("energy weapons")

func _on_longwepup_pressed():
	increase_skill("long weapons")

func _on_longwepdown_pressed():
	decrease_skill("long weapons")

func _on_smallwepup_pressed():
	increase_skill("small weapons")

func _on_smallwepdown_pressed():
	decrease_skill("small weapons")

func _on_bladwepup_pressed():
	increase_skill("bladed weapons")

func _on_bladewepdown_pressed():
	decrease_skill("bladed weapons")

func _on_blunwepup_pressed():
	increase_skill("blunt weapons")

func _on_blunwepdown_pressed():
	decrease_skill("blunt weapons")

# row two buttons
func _on_brawlwepup_pressed():
	increase_skill("brawling weapons")

func _on_brawlwepdown_pressed():
	decrease_skill("brawling weapons")

func _on_medicup_pressed():
	increase_skill("medic")

func _on_medicdown_pressed():
	decrease_skill("medic")

func _on_doctorup_pressed():
	increase_skill("doctor")

func _on_doctordown_pressed():
	decrease_skill("doctor")

func _on_perceptup_pressed():
	increase_skill("perception")

func _on_perceptdown_pressed():
	decrease_skill("perception")

func _on_lockpickup_pressed():
	increase_skill("lock picking")

func _on_lockpickdown_pressed():
	decrease_skill("lock picking")

func _on_bombdisup_pressed():
	increase_skill("bomb disarming")

func _on_bombdisdown_pressed():
	decrease_skill("bomb disarming")

func _on_safecrackup_pressed():
	increase_skill("safe cracking")

func _on_safecrackdown_pressed():
	decrease_skill("safe cracking")

# row three Buttons
func _on_elecup_pressed():
	increase_skill("electronics")

func _on_elecdown_pressed():
	decrease_skill("electronics")

func _on_mechup_pressed():
	increase_skill("mechanical repair")

func _on_mechdown_pressed():
	decrease_skill("mechanical repair")

func _on_confup_pressed():
	increase_skill("confidence")

func _on_confdown_pressed():
	decrease_skill("confidence")

func _on_intimidateup_pressed():
	increase_skill("intimidation")

func _on_intimidatedown_pressed():
	decrease_skill("intimidation")

func _on_alarmdisup_pressed():
	increase_skill("alarm disarming")

func _on_alarmdisdown_pressed():
	decrease_skill("alarm disarming")

func _on_combatcontup_pressed():
	increase_skill("combat control")

func _on_combatcontdown_pressed():
	decrease_skill("combat control")

func _on_leaderup_pressed():
	increase_skill("leadership")

func _on_leaderdown_pressed():
	decrease_skill("leadership")
	
