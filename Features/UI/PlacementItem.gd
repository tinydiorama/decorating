extends PanelContainer

@onready var button = %IconButton
@onready var outlineSprite = %OutlineSprite
@onready var nameNode = %ItemName

var itemData:PlaceableItem

func display(inventoryItem:PlaceableItem):
	nameNode.text = inventoryItem.name
	button.texture_normal = inventoryItem.inventoryTexture
	outlineSprite.texture = inventoryItem.inventoryOutline
	itemData = inventoryItem
