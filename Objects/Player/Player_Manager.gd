extends Node

@onready var player = get_tree().current_scene.get_node("/root/World/Player")
@onready var player_skills = PlayerSkills.new()


func use_slot_data(slot_data: SlotData) -> void:
	slot_data.item_data.use(player)


func get_global_position() -> Vector2:
	return player.global_position

func _ready():
	player_skills.connect("skill_leveled_up", Callable(self, "_on_skill_leveled_up"))
	print_player_skills()
	

func get_skill_level(skill_name):
	return player_skills.get_skill_level(skill_name)

func get_skill_exp(skill_name):
	return player_skills.get_skill_exp(skill_name)

func increase_skill_exp(skill_name, amount):
	player_skills.increase_skill_exp(skill_name, amount)

func _on_skill_leveled_up(skill_name, new_level):
	# Implement level-up logic here
	print("%s leveled up to %d" % [skill_name, new_level])
	# You can emit signals or call functions in other systems to handle level-up effects
	# (e.g., update UI, unlock new recipes, enable new resource gathering options)

func print_player_skills():
	print("Player Skills:")
	for skill_name in player_skills.skills.keys():
		var skill_level = get_skill_level(skill_name)
		var skill_exp = get_skill_exp(skill_name)
		print("%s: Level %d, Experience %d" % [skill_name, skill_level, skill_exp])
		

