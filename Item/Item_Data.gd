extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture
@export var gold_value: int = 1


@export_enum ("Weapon", "Armor", "Potion", "Quest_Item", "Accessory", "Material", "Currency")
var type : String = ""

@export_enum("Common", "Uncommon", "Rare", "Epic", "Legendary")
var rarity : String = "Common"



func use(_target) -> void:
	pass


func is_currency() -> bool:
	return type == "Currency"
