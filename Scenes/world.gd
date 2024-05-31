extends Node2D


@onready var player = $Player


@onready var inventory_interface: Control = $InventoryUI/InventoryInterface
@onready var hotbar_inventory = $InventoryUI/HotBarInventory



func _ready() -> void:
	
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_hotbar_inventory_data(player.hotbar_inventory_data)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)



func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()





#Method below, is a example how to add a new item with a button and award experience.
func _on_button_pressed():
	var item: ItemData = preload('res://Item/Items/ItemTypes/Materials/Iron_Bar.tres')
	var slot_data = SlotData.new()
	slot_data.item_data = item
	slot_data.quantity = 1
	player.inventory_data.pick_up_slot_data(slot_data)
	PlayerManager.increase_skill_exp("Woodcutting", 10)
	print(PlayerManager.get_skill_exp("Woodcutting"))
		 ##Call the harvest function of the ResourceNode\
	var resource_node = $TestResourceNode
	var result = resource_node.harvest()

	## Handle the result or add additional logic as needed
	if result:
		print("Harvest successful!")
	elif result == null:
		return
	else:
		print("Harvest failed!")
	pass
