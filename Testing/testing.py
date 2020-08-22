import random


class Weapon:

    def __init__(self, damage, name, crit, accuracy, skill, min_skill):
        self.damage = damage
        self.name = name
        self.critical_bonus = crit
        self.accuracy = accuracy
        self.skill = skill
        self.minimum_skill = min_skill

    def calculate_hit(self, player_skill):
        if player_skill >= self.minimum_skill:
            # normal accuracy for adequate skill levels
            return self.hit_test(player_skill)
        else:
            # too low of a skill to use it well
            return self.hit_test(-player_skill)

    def hit_test(self, skill):
        for i in range(4):
            chance = random.randint(0, 100)
            if chance <= self.accuracy + skill:
                return True
            else:
                return False


class Character:

    def __init__(self):
        # unit name
        self.name = None
        # unit weapon
        self.weapon = None
        # critical chance
        self.__critical_chance = 5
        # unit health default of 20
        self.__health = 20
        # unit level
        self.__level = 1
        # a dictionary of stats
        self.stat_dict = {
            "strength": 1,
            "intelligence": 1,
            "luck": 1,
            "speed": 1,
            "agility": 1,
            "dexterity": 1,
            "charisma": 1
                         }

        # a dictionary of skills
        self.skill_dict = {
            "small arms": 0,
            "large arms": 0,
            "explosives": 0,
            "swimming": 0,
            "lock picking": 0
                          }

    @property
    def critical_chance(self):
        return self.__critical_chance + self.stat_dict["luck"]

    @property
    def level(self):
        return self.__level

    @level.setter
    def level(self, new_level):
        self.__level = new_level

    @property
    def health(self):
        return self.__health

    def set_health(self):
        self.__health = (20 * self.stat_dict.get("strength")) * self.level

    def level_up(self):
        skills_to_spend = self.stat_dict["intelligence"] * 2
        self.level += 1
        # functions to increase skills
        self.set_health()


squad_list = []
count = 0
while len(squad_list) < 2:
    squad_list.append(Character())
    member = squad_list[count]
    member.name = input("Character name? ")
    for stat in member.stat_dict:
        print(f"1-10 for {stat}")
        member.stat_dict[stat] = int(input("? "))
    member.set_health()
    count += 1

for member in squad_list:
    print(f"{member.name} {member.health}")


