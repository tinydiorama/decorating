extends Control

@onready var itemList = %ItemList

var placementButton = preload("res://Features/UI/placement_item.tscn")

signal closeItemsPanel
signal itemSelected(item:PlaceableItem)

func loadFromInventory() -> void:
	var inventory = Inventory.getInventory()
	
	for child in itemList.get_children():
		itemList.remove_child(child)
		child.queue_free() 
	
	for inventoryItem in inventory:
		var inventoryItemButton = placementButton.instantiate()
		itemList.add_child(inventoryItemButton)
		inventoryItemButton.display(inventoryItem)
		inventoryItemButton.button.connect("pressed", Callable(self, "selectItem").bind([inventoryItem]))
	
func selectItem(params:Array):
	var selectedItem = params[0] as PlaceableItem
	itemSelected.emit(selectedItem)

func _on_close_button_pressed():
	closeItemsPanel.emit()
