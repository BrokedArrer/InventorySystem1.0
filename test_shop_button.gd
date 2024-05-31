extends Node2D


@export var slot : SlotData




func _on_button_pressed():
	if PlayerManager.player.inventory_data.player_gold >= slot.item_data.gold_value:
		PlayerManager.player.inventory_data.pick_up_slot_data(slot)
		PlayerManager.player.inventory_data.player_gold -= slot.item_data.gold_value
		print('item was purchased')
	elif PlayerManager.player.inventory_data.player_gold < slot.item_data.gold_value:
		return
		print('Not enough gold to purchase the item')
	
