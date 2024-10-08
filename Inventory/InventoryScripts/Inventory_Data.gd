extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button:int)

@export var slots: Array[SlotData]


var player_gold: int = 0

func _ready():
	calculate_player_gold()

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slots[index]
	
	if slot_data:
		slots[index] = null
		inventory_updated.emit(self)
		calculate_player_gold()
		return slot_data
	else:
		return null
		
func drop_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slots[index]
	var return_slot_data: SlotData
	if slot_data and slot_data.item_data == grabbed_slot_data.item_data:
		# Merge the stacks
		var remaining_quantity: int = grabbed_slot_data.quantity
		var merge_quantity: int
		if slot_data.item_data.is_currency():
			merge_quantity = remaining_quantity
		else:
			merge_quantity = min(remaining_quantity, slot_data.MAX_STACK_SIZE - slot_data.quantity)
		slot_data.quantity += merge_quantity
		remaining_quantity -= merge_quantity
		if remaining_quantity > 0:
			grabbed_slot_data.quantity = remaining_quantity
			return_slot_data = grabbed_slot_data
		else:
			return_slot_data = null
	else:
		# Replace the slot with the grabbed slot data
		slots[index] = grabbed_slot_data
		return_slot_data = slot_data
	inventory_updated.emit(self)
	calculate_player_gold()
	return return_slot_data
	
func drop_single_slot_data(grabbed_slot_data: SlotData, index: int) -> SlotData:
	var slot_data = slots[index]
	
	if not slot_data:
		slots[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
	
	inventory_updated.emit(self)
	calculate_player_gold()
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null


func use_slot_data(index: int) -> void:
	var slot_data = slots[index]
	
	if not slot_data:
		return
		
	if slot_data.item_data is ItemDataConsumable:
		slot_data.quantity -= 1
		if slot_data.quantity < 1:
			slots[index] = null
		
	print(slot_data.item_data.name)
	PlayerManager.use_slot_data(slot_data)
	
	inventory_updated.emit(self)
	calculate_player_gold()




func pick_up_slot_data(slot_data: SlotData) -> bool:
	for index in slots.size():
		if slots[index] and slots[index].can_fully_merge_with(slot_data):
			slots[index].fully_merge_with(slot_data)
			inventory_updated.emit(self)
			calculate_player_gold()
			return true
			
	for index in slots.size():
		if not slots[index]:
			slots[index] = slot_data
			inventory_updated.emit(self)
			calculate_player_gold()
			return true
	
	return false

func on_slot_clicked(index: int, button:int) -> void:
	inventory_interact.emit(self, index, button)

func calculate_player_gold() -> void:
	player_gold = 0
	
	for slot_data in slots:
		if slot_data and slot_data.item_data.is_currency():
			player_gold += slot_data.quantity
			print(player_gold)
