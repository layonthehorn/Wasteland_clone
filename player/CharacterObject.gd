class_name CharacterObject

const BASE_HEALTH = 20
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

var name = null setget name_set, name_get
var health = null setget health_set, health_get
var level = BASE_LEVEL setget level_set, level_get
var crit_chance = BASE_CRIT setget crit_chance_set, crit_chance_get
var max_health = null setget max_health_set, max_health_get
var experience = BASE_EXP setget experience_set, experience_get
var skill_points = BASE_SKILL_POINTS setget skill_points_set, skill_points_get

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

func skill_points_get():
	return skill_points

func skill_points_set(value):
	skill_points = value

func experience_get():
	return experience

func experience_set(value):
	experience = value

func name_get():
	return name
	
func name_set(value):
	name = value

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
	max_health = (BASE_HEALTH + level) * stat_dict.get("strength")
	
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
	elif -600 < health <= 0:
		character_state = COMBAT_STATE.DYING
		health = health - BASE_BLEEDING_DAMAGE
	# if character is below -600 health,
	# they are dead and gone
	else:
		character_state = COMBAT_STATE.DEAD

# heals you while camping.
func camping_healing():
	if health < max_health:
		# prevents healing over max health
		heal_player(BASE_HEALING)

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

func _init(char_name, stat_dictionary, skill_dictionary):
	self.stat_dict = stat_dictionary
	self.skill_dict = skill_dictionary
	self.name = char_name
