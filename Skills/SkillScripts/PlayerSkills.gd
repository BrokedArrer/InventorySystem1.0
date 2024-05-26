extends Node
class_name PlayerSkills

const MAX_LEVEL = 99

# Define the skills dictionary with initial level and experience
var skills = {
	"Attack": {"level": 1, "exp": 0},
	"Strength": {"level": 1, "exp": 0},
	"Defence": {"level": 1, "exp": 0},
	"Hitpoints": {"level": 1, "exp": 0},
	"Ranged": {"level": 1, "exp": 0},
	"Prayer": {"level": 1, "exp": 0},
	"Magic": {"level": 1, "exp": 0},
	"Cooking": {"level": 1, "exp": 0},
	"Woodcutting": {"level": 1, "exp": 0},
	"Fletching": {"level": 1, "exp": 0},
	"Fishing": {"level": 1, "exp": 0},
	"Firemaking": {"level": 1, "exp": 0},
	"Crafting": {"level": 1, "exp": 0},
	"Smithing": {"level": 1, "exp": 0},
	"Mining": {"level": 1, "exp": 0},
	"Herblore": {"level": 1, "exp": 0},
	"Agility": {"level": 1, "exp": 0},
	"Thieving": {"level": 1, "exp": 0},
	"Slayer": {"level": 1, "exp": 0},
	"Farming": {"level": 1, "exp": 0},
	"Runecrafting": {"level": 1, "exp": 0},
}

# Dictionary to store the experience required for each level
# Based on the RuneScape Classic experience curve
var exp_curve = {
	1: 0, 2: 83, 3: 174, 4: 276, 5: 388, 6: 512, 7: 650, 8: 801, 9: 969, 10: 1154,
	11: 1358, 12: 1584, 13: 1833, 14: 2107, 15: 2411, 16: 2746, 17: 3115, 18: 3523,
	19: 3973, 20: 4470, 21: 5018, 22: 5624, 23: 6291, 24: 7028, 25: 7842, 26: 8740,
	27: 9730, 28: 10824, 29: 12031, 30: 13363, 31: 14833, 32: 16456, 33: 18247,
	34: 20224, 35: 22406, 36: 24815, 37: 27473, 38: 30408, 39: 33648, 40: 37224,
	41: 41171, 42: 45529, 43: 50339, 44: 55649, 45: 61512, 46: 67983, 47: 75127,
	48: 83014, 49: 91721, 50: 101333, 51: 111945, 52: 123660, 53: 136594, 54: 150872,
	55: 166636, 56: 184040, 57: 203254, 58: 224466, 59: 247886, 60: 273742, 61: 302288,
	62: 333804, 63: 368599, 64: 407015, 65: 449428, 66: 496254, 67: 547953, 68: 605032,
	69: 668051, 70: 737627, 71: 814445, 72: 899192, 73: 992554, 74: 1095224,
	75: 1207889, 76: 1331239, 77: 1465959, 78: 1612728, 79: 1772214, 80: 1945063,
	81: 2132909, 82: 2336369, 83: 2556938, 84: 2795091, 85: 3051279, 86: 3325929,
	87: 3619443, 88: 3932199, 89: 4264547, 90: 4616815, 91: 4989309, 92: 5382310,
	93: 5796062, 94: 6230776, 95: 6686630, 96: 7163773, 97: 7662320, 98: 8182351,
	99: 8724832
}

signal skill_leveled_up(skill_name, new_level)

# Function to get the level of a specific skill
func get_skill_level(skill_name):
	return skills[skill_name]["level"]

# Function to get the experience of a specific skill
func get_skill_exp(skill_name):
	return skills[skill_name]["exp"]

# Function to increase the experience of a specific skill
func increase_skill_exp(skill_name, amount):
	skills[skill_name]["exp"] += amount
	update_skill_level(skill_name)

# Function to update the level of a specific skill based on experience
func update_skill_level(skill_name):
	var current_level = skills[skill_name]["level"]
	while skills[skill_name]["exp"] >= exp_required_for_next_level(skills[skill_name]["level"]):
		skills[skill_name]["level"] += 1
		if skills[skill_name]["level"] > MAX_LEVEL:
			skills[skill_name]["level"] = MAX_LEVEL
			break
		emit_signal("skill_leveled_up", skill_name, skills[skill_name]["level"])
		current_level += 1

# Function to calculate the experience required for the next level of a skill
func exp_required_for_next_level(current_level):
	if current_level >= exp_curve.size():
		return exp_curve[exp_curve.size()]
	return exp_curve[current_level + 1]
