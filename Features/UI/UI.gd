extends CanvasLayer

@onready var overlay = %Overlay
@onready var itemsPanel = %ItemsPanel
@onready var decoratingMenuButton = %DecoratingMenuButton

signal itemSelected(item:PlaceableItem)

func _on_decorating_menu_button_pressed():
	itemsPanel.show()
	overlay.show()
	itemsPanel.loadFromInventory()
	decoratingMenuButton.hide()
	ItemPlacer.placeItem()


func _on_items_panel_close():
	itemsPanel.hide()
	overlay.hide()
	decoratingMenuButton.show()


func _on_items_panel_item_selected(item):
	_on_items_panel_close()
	itemSelected.emit(item)
	
