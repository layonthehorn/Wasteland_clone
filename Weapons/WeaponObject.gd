class_name WeaponObject

# basic weapon stats
var name = null setget name_set, name_get
var min_damage = null setget min_damage_set, min_damage_get
var max_damage = null setget max_damage_set, max_damage_get
var accuracy = null setget accuracy_set, accuracy_get
var crit_chance = null setget crit_chance_set, crit_chance_get
var usage_skill = null setget usage_skill_set, usage_skill_get
var min_skill = null setget min_skill_set, min_skill_get

func min_skill_get():
	return min_skill
	
func min_skill_set(value):
	min_skill = value

func usage_skill_get():
	return usage_skill

func usage_skill_set(value):
	usage_skill = value

func crit_chance_get():
	return crit_chance

func crit_chance_set(value):
	crit_chance = value

func accuracy_get():
	return accuracy

func accuracy_set(value):
	accuracy = value

func max_damage_get():
	return max_damage

func max_damage_set(value):
	max_damage = value

func min_damage_get():
	return min_damage
	
func min_damage_set(value):
	min_damage = value

func name_get():
	return name

func name_set(value):
	name = value



func _init(name):
	self.name = name
	# opening stats json to read settings for requested weapon
	var weapon_stats = File.new()
	weapon_stats.open("res://Weapons/weapon_stats.json", weapon_stats.READ)
	var settings = parse_json(weapon_stats.get_as_text())
	weapon_stats.close()
	for weapon in settings:
		if weapon == self.name:
			# load stats
			weapon_stats = settings.get(weapon)
			max_damage = weapon_stats.get("max_damage")
			min_damage = weapon_stats.get("min_damage")
			accuracy = weapon_stats.get("accuracy")
			crit_chance = weapon_stats.get("critical chance")
			min_skill = weapon_stats.get("min skill")
			usage_skill = weapon_stats.get("usage skill")
			# quit loop
			break


