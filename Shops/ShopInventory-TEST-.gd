#extends "res://Inventory/InventoryScripts/Inventory.gd"
#
#
#const BuyButton = preload('res://Inventory/InventoryScenes/BuyButton.tscn')
#const SellButton = preload('res://Inventory/InventoryScenes/SellButton.tscn')
#
#@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
#@onready var buy_grid: GridContainer = $MarginContainer/BuyGrid
#@onready var sell_grid: GridContainer = $MarginContainer/SellGrid
#
#var shop_inventory: InventoryData
#
#func set_shop_inventory(inventory_data: InventoryData) -> void:
	#shop_inventory = inventory_data
	#populate_buy_grid()
	#populate_sell_grid()
#
#func populate_buy_grid() -> void:
	#for child in buy_grid.get_children():
		#child.queue_free()
#
	#for slot_data in shop_inventory.slots:
		#if slot_data and slot_data.item_data:
			#var buy_button = BuyButton.instantiate()
			#buy_button.set_slot_data(slot_data)
			#buy_button.connect("buy_pressed", self, "_on_buy_pressed")
			#buy_grid.add_child(buy_button)
#
#func populate_sell_grid() -> void:
	#for child in sell_grid.get_children():
		#child.queue_free()
#
	#for slot_data in player_inventory.slots:
		#if slot_data and slot_data.item_data:
			#var sell_button = SellButton.instantiate()
			#sell_button.set_slot_data(slot_data)
			#sell_button.connect("sell_pressed", self, "_on_sell_pressed")
			#sell_grid.add_child(sell_button)
#
#func _on_buy_pressed(slot_data: SlotData) -> void:
	#var player_manager = get_node("/root/PlayerManager")
	#if player_manager.subtract_currency(slot_data.value):
		#shop_inventory.remove_item(slot_data)
		#player_inventory.add_item(slot_data)
#
#func _on_sell_pressed(slot_data: SlotData) -> void:
	#var player_manager = get_node("/root/PlayerManager")
	#if player_inventory.remove_item(slot_data):
		#shop_inventory.add_item(slot_data)
		#player_manager.add_currency(slot_data.value)
