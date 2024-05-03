extends Node

var inventory:Array[PlaceableItem] = []

func addItem(item:PlaceableItem):
	if ( ! inventory.has(item) ):
		inventory.append(item)

func removeItem(item:PlaceableItem):
	if ( inventory.has(item) ):
		inventory.erase(item)

func getInventory() -> Array[PlaceableItem]:
	return inventory
