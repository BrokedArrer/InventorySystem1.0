extends Node
#
#const PlayerSkills = preload('res://Skills/SkillScripts/PlayerSkills.gd')
#
#var player_skills = PlayerSkills.new()
#
#func _ready():
	#player_skills.connect("skill_leveled_up", Callable(self, "_on_skill_leveled_up"))
#
#func get_skill_level(skill_name):
	#return player_skills.get_skill_level(skill_name)
#
#func get_skill_exp(skill_name):
	#return player_skills.get_skill_exp(skill_name)
#
#func increase_skill_exp(skill_name, amount):
	#player_skills.increase_skill_exp(skill_name, amount)
#
#func _on_skill_leveled_up(skill_name, new_level):
	## Implement level-up logic here
	#print("%s leveled up to %d" % [skill_name, new_level])
	## You can emit signals or call functions in other systems to handle level-up effects
	## (e.g., update UI, unlock new recipes, enable new resource gathering options)
