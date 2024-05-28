# ResourceNode.gd
extends Node2D
class_name ResourceNode

# Resource data property
@export var resource_data: ResourceData

@onready var _pm = $PopupMenu
var _last_mouse_position

enum PopupIds {
	HARVEST,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	_pm.add_item('Harvest', PopupIds.HARVEST)
	_pm.connect('id_pressed', Callable(self, '_on_PopipMenu_id_pressed'))
	_pm.connect('index_pressed', Callable(self, '_on_PopipMenu_index_pressed'))

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		#_last_mouse_position = get_global_mouse_position()
		#_pm.popup(Rect2(_last_mouse_position.x, _last_mouse_position.y, _pm.size.x, _pm.size.y))
		pass

# Harvest function
func harvest():
	if resource_data.resource_type == ResourceData.ResourceType.NONE:
		# Handle the case when resource_type is NONE
		return false

	var player_skill_level = PlayerManager.get_skill_level(get_skill_name(resource_data.resource_type))
	if player_skill_level >= resource_data.level_required:
		var exp_gain = resource_data.calculate_skill_exp_gain()
		PlayerManager.increase_skill_exp(get_skill_name(resource_data.resource_type), exp_gain)
		
		# Grant the resource item to the player
		var slot_data = SlotData.new()
		slot_data.item_data = resource_data.resource_item_data
		slot_data.quantity = resource_data.resource_amount
		#player.inventory_data.pick_up_slot_data(slot_data)
		PlayerManager.player.inventory_data.pick_up_slot_data(slot_data)
		
		print('item: ', slot_data.item_data.name, ' | ',  'Exp: ', exp_gain)
		
		# Consume the resource node
		#queue_free()
		return true
	else:
		# Player's skill level is too low
		return false

func get_skill_name(resource_type):
	match resource_type:
		ResourceData.ResourceType.MINING:
			return "Mining"
		ResourceData.ResourceType.WOODCUTTING:
			return "Woodcutting"
		ResourceData.ResourceType.FISHING:
			return "Fishing"
		ResourceData.ResourceType.FARMING:
			return "Farming"
		_:
			return ""


func _on_popup_menu_id_pressed(id):
	match id:
		PopupIds.HARVEST:
			harvest()

func _on_popup_menu_index_pressed(index):
	print_debug(index)
