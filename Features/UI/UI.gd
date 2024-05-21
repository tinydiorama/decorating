extends CanvasLayer

@onready var overlay = %Overlay
@onready var itemsPanel = %ItemsPanel
@onready var decoratingMenuButton = %DecoratingMenuButton

signal itemSelected(item:PlaceableItem)

func _ready() -> void:
	SignalBus.onFurnitureActive.connect(_on_furniture_active)
	SignalBus.onFurnitureInactive.connect(_on_furniture_inactive)

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
	
func _on_furniture_active():
	decoratingMenuButton.hide()

func _on_furniture_inactive():
	decoratingMenuButton.show()
