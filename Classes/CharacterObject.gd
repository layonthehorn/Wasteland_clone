class_name CharacterObject

const BASE_HEALTH = 15
const BASE_CRIT = 5
const BASE_LEVEL = 1
const BASE_BLEEDING_DAMAGE = 20
const BASE_HEALING = 5
const BASE_EXP = 0
const BASE_SKILL_POINTS = 0
const BASE_SKILL_POINTS_LEVEL = 2
# needed exp for each level
const REQUIRED_EXP = {
	2: 300,
	3: 700,
	4: 1200,
	5: 1800,
	6: 2500,
	7: 3400,
	8: 4300,
	9: 5400,
	10: 6600,
	11: 7900,
	12: 9300,
	13: 10800,
	14: 12400,
	15: 14100
}

enum COMBAT_STATE {
	ALIVE,
	DYING,
	DEAD
}

var f_name:= "" setget f_name_set, f_name_get
var l_name:= "" setget l_name_set, l_name_get
var health:= 0 setget health_set, health_get
var level:= BASE_LEVEL setget level_set, level_get
var crit_chance:= BASE_CRIT setget crit_chance_set, crit_chance_get
var max_health:= 0 setget max_health_set, max_health_get
var experience:= BASE_EXP setget experience_set, experience_get
var skill_points:= BASE_SKILL_POINTS setget skill_points_set, skill_points_get
var race:= "" setget race_set, race_get
var age:= "" setget age_set, age_get
var bio:= "" setget bio_set, bio_get
var gender:= "" setget gender_set, gender_get
var primary:= "" setget primary_set, primary_get
var secondary:= "" setget secondary_set, secondary_get

# we import the full stat dict when instansting the class
#{
#            "strength": 1,
#            "intelligence": 1,
#            "luck": 1,
#            "speed": 1,
#            "agility": 1,
#            "dexterity": 1,
#            "charisma": 1
#                         }
var stat_dict = null

# character skill dictionary
#{
#            "small arms": 0,
#            "large arms": 0,
#            "explosives": 0,
#            "swimming": 0,
#            "lock picking": 0
#                          }
var skill_dict = null
# character state
var character_state = COMBAT_STATE.ALIVE

func age_get():
	return age

func age_set(value):
	age = value

func secondary_get():
	return secondary

func secondary_set(sec):
	secondary = sec

func primary_get():
	return primary

func primary_set(prim):
	primary = prim

func gender_get():
	return gender

func gender_set(gend):
	gender = gend

func bio_set(bio_value):
	bio = bio_value

func bio_get():
	return bio

func l_name_get():
	return l_name

func l_name_set(name):
	l_name = name

func race_get():
	return race
	
func race_set(value):
	race = value

func skill_points_get():
	return skill_points

func skill_points_set(value):
	skill_points = value

func experience_get():
	return experience

func experience_set(value):
	experience = value

func f_name_get():
	return f_name
	
func f_name_set(value):
	f_name = value

# health functions
func health_get():
	return health

func health_set(value):
	health = value

func max_health_get():
	return max_health

func max_health_set(value):
	max_health = value

func update_max_health():
	max_health = BASE_HEALTH + (stat_dict.get("strength") * 2 * level)
	
func level_get():
	return level

func level_set(value):
	level = value

func crit_chance_get():
	return crit_chance + stat_dict.get("luck")
	
func crit_chance_set(value):
	crit_chance = value

# checks if the character is able to fight
func is_combat_effective():
	# if character is over 0 health,
	# they can fight.
	if health > 0:
		character_state = COMBAT_STATE.ALIVE
	# if character is below or equal to 0 health,
	# they are bleeding out and unable to fight
	elif -600 < health and health <= 0:
		character_state = COMBAT_STATE.DYING
		health = health - BASE_BLEEDING_DAMAGE
	# if character is below -600 health,
	# they are dead and gone
	else:
		character_state = COMBAT_STATE.DEAD

# heals you while camping.
func camping_healing():
	if health < max_health:
		heal_player(BASE_HEALING)

# prevents healing over max health
func heal_player(heal_value):
	health = clamp(heal_value, health, max_health)

# levels the player up until they are at the correct 
# level for their EXP
func level_up():
	var count = level + 1
	while (experience >= REQUIRED_EXP.get(count)):
		# increases your skill points as needed
		level += 1
		count += 1
		skill_points += calc_new_skill_points()
	# updates your max health
	update_max_health()

func calc_new_skill_points():
	if stat_dict.get("intelligence") > 1:
		return BASE_SKILL_POINTS_LEVEL + stepify((stat_dict.get("intelligence") / 2), 1)
	else:
		return BASE_SKILL_POINTS_LEVEL

func _init():
	pass