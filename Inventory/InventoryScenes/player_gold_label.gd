extends Label

var inventory_data: InventoryData

func _ready():
	inventory_data = PlayerManager.player.inventory_data
	update_gold_label()

func _process(_delta):
	if inventory_data.player_gold != int(text):
		update_gold_label()

func update_gold_label() -> void:
	text = str("Gold: ", inventory_data.player_gold)
