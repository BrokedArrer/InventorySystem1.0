# ResourceData.gd
class_name ResourceData
extends Resource

# Resource type enum
enum ResourceType {NONE, MINING, WOODCUTTING, FISHING, FARMING}

# Resource subtypes
const MiningSubtype = {
	COAL = "COAL",
	COPPER = "COPPER",
	IRON = "IRON",
	GOLD = "GOLD",
	DIAMOND = "DIAMOND"
}
const WoodcuttingSubtype = {
	OAK = "OAK",
	BIRCH = "BIRCH",
	SPRUCE = "SPRUCE",
	JUNGLE = "JUNGLE"
}
const FishingSubtype = {
	SALMON = "SALMON",
	COD = "COD",
	TUNA = "TUNA",
	BASS = "BASS"
}
const FarmingSubtype = {
	WHEAT = "WHEAT",
	CARROTS = "CARROTS",
	POTATOES = "POTATOES",
	BEETROOTS = "BEETROOTS"
}

# Properties
@export var resource_type: ResourceType
@export_enum("COAL", "COPPER", "IRON", "GOLD", "DIAMOND") var mining_subtype: String
@export_enum("OAK", "BIRCH", "SPRUCE", "JUNGLE") var woodcutting_subtype: String
@export_enum("SALMON", "COD", "TUNA", "BASS") var fishing_subtype: String
@export_enum("WHEAT", "CARROTS", "POTATOES", "BEETROOTS") var farming_subtype: String
@export var level_required: int = 1
@export var resource_amount: int = 5
@export var resource_item_data: ItemData


# Function to calculate the skill experience gain (to be overridden by child classes)
func calculate_skill_exp_gain():
	return 10 # Replace with your desired experience gain calculation
