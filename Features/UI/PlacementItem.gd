extends PanelContainer

@onready var button = %IconButton
@onready var nameNode = %ItemName

var itemData:PlaceableItem

func display(inventoryItem:PlaceableItem):
	nameNode.text = inventoryItem.name
	button.texture_normal = inventoryItem.inventoryTexture
	itemData = inventoryItem
