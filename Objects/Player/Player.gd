extends CharacterBody2D
class_name Player

signal toggle_inventory()
#Player Inventory vars.
@export var inventory_data: InventoryData
@export var equip_inventory_data: InventoryDataEquip
@export var hotbar_inventory_data: InventoryDataHotbar

var speed = 100
var direction: Vector2 = Vector2.ZERO
var target_position: Vector2 = Vector2.ZERO
var is_moving: bool = false
var smooth_time: float = 0.2


func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("Inventory"):
		toggle_inventory.emit()



func _process(delta):
	hotbar_controls()

	# Check if the left mouse button is pressed.
	if Input.is_action_pressed("move"):
		# Update the target position every frame.
		target_position = get_global_mouse_position()
		# Calculate the direction and move the player towards the target position.
		direction = (target_position - position).normalized()
		velocity = velocity.lerp(direction * speed, smooth_time)
		is_moving = true
	else:
		# If the left mouse button is not pressed, stop the movement.
		velocity = Vector2.ZERO
		is_moving = false



func _physics_process(delta):
	if is_moving:
		# Check if the player has reached the target position.
		if position.distance_to(target_position) < 1:
			# If the player has reached the target position, stop the movement.
			velocity = Vector2.ZERO
			is_moving = false
	move_and_slide()



func heal(_heal_value: int) -> void:
	pass

func hotbar_controls():
	#for i in range(10):
		#if Input.is_action_just_released("hotbar_" + str(i)):
			#hotbar_inventory_data.use_slot_data(i)
	pass

