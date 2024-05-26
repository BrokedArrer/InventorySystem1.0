extends Node

@export var recipes: Array[CraftingRecipe]

@onready var recipe_button_container = $RecipeButtonContainer


func _ready():
	var recipe_dir = 'res://Crafting/Recipes/'
	var recipe_files = []
	var dir = DirAccess.open(recipe_dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				recipe_files.append(recipe_dir + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	
	for recipe_file in recipe_files:
		var recipe = load(recipe_file)
		recipes.append(recipe)
		# Create a button for the recipe
		var recipe_button = Button.new()
		recipe_button.icon = recipe.crafted_item.texture
		recipe_button.connect("pressed", Callable(self, "_on_recipe_button_pressed").bind(recipe))
		recipe_button.custom_minimum_size = Vector2(64, 64)
		recipe_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		recipe_button.expand_icon = true
		recipe_button_container.add_child(recipe_button)


func can_craft(inventory: InventoryData, recipe: CraftingRecipe) -> bool:
	for requirement in recipe.requirements:
		var found_quantity: int = 0
		for slot_data in inventory.slots:
			if slot_data and slot_data.item_data == requirement.item_data:
				found_quantity += slot_data.quantity
		if found_quantity < requirement.quantity:
			return false
	return true

func craft(inventory: InventoryData, recipe: CraftingRecipe) -> void:
	if can_craft(inventory, recipe):
		for requirement in recipe.requirements:
			var slot_index_to_reduce = -1
			var slot_found = false
			for i in range(inventory.slots.size()):
				var slot_data: SlotData = inventory.slots[i]
				if slot_data and slot_data.item_data == requirement.item_data:
					slot_index_to_reduce = i
					slot_found = true
					break

			if slot_found:
				var slot_data: SlotData = inventory.slots[slot_index_to_reduce]
				slot_data.quantity -= requirement.quantity
				if slot_data.quantity <= 0:
					inventory.slots[slot_index_to_reduce] = null

		var crafted_slot_data = SlotData.new()
		crafted_slot_data.item_data = recipe.crafted_item
		crafted_slot_data.quantity = recipe.crafted_quantity

		if crafted_slot_data.item_data.stackable:
			# Find the first available slot to merge the crafted items with
			var remaining_quantity: int = recipe.crafted_quantity
			for i in range(inventory.slots.size()):
				var slot_data: SlotData = inventory.slots[i]
				if slot_data and slot_data.item_data == recipe.crafted_item:
					var merge_quantity = min(remaining_quantity, slot_data.MAX_STACK_SIZE - slot_data.quantity)
					slot_data.quantity += merge_quantity
					remaining_quantity -= merge_quantity
					if remaining_quantity == 0:
						break

			# If there are still remaining crafted items, create a new slot
			if remaining_quantity > 0:
				var empty_slot_index: int = -1
				for i in range(inventory.slots.size()):
					if not inventory.slots[i]:
						empty_slot_index = i
						break

				if empty_slot_index != -1:
					crafted_slot_data.quantity = remaining_quantity
					inventory.slots[empty_slot_index] = crafted_slot_data
				else:
					print("Discarded remaining quantity: ", remaining_quantity)
		else:
			# For non-stackable items, create a new slot for each crafted item
			for i in range(recipe.crafted_quantity):
				var empty_slot_index: int = -1
				for j in range(inventory.slots.size()):
					if not inventory.slots[j]:
						empty_slot_index = j
						break

				if empty_slot_index != -1:
					crafted_slot_data.quantity = 1
					inventory.slots[empty_slot_index] = crafted_slot_data
				else:
					print("Discarded crafted item due to lack of space")

		inventory.inventory_updated.emit(inventory)

func _on_recipe_button_pressed(recipe: CraftingRecipe):
	var player_inventory = load('res://Inventory/Inventory Resources/Inventory.tres')
	craft(player_inventory, recipe)
