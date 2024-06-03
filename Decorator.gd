extends Node2D

@export var actualItemData:PlaceableItem
@export var itemData2:PlaceableItem
@export var itemData3:PlaceableItem
@export var itemData4:PlaceableItem
@export var itemData5:PlaceableItem
@export var itemData6:PlaceableItem
@export var itemData7:PlaceableItem
@export var itemData8:PlaceableItem
@export var itemData9:PlaceableItem
@export var floorData1:FloorWallOption

func _ready() -> void:
	Inventory.addItem(actualItemData)
	Inventory.addItem(itemData2)
	Inventory.addItem(itemData3)
	Inventory.addItem(itemData4)
	Inventory.addItem(itemData5)
	Inventory.addItem(itemData6)
	Inventory.addItem(itemData7)
	Inventory.addItem(itemData8)
	Inventory.addItem(itemData9)
	Inventory.addFloorOption(floorData1)
	
func handleItemSelection(params:Array) -> void:
	var item = params[0]
	
	if ( item == null ):
		return
	
	ItemPlacer.itemToPlace = item
	ItemPlacer.newObjectCreated()


func _on_ui_item_selected(item):
	ItemPlacer.itemToPlace = item
	ItemPlacer.newObjectCreated()
