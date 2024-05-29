extends Control

var optionScene = preload("res://Features/UI/floor_wall_option.tscn")

@onready var floorButton = %FloorButton
@onready var wallButton = %WallButton
@onready var optionsPanel = %WallFloorOptions
@onready var optionList = %OptionList

func _on_floor_button_pressed():
	var inventory = Inventory.getFloorOptions()
	
	optionsPanel.show()
	for child in optionList.get_children():
		optionList.remove_child(child)
		child.queue_free() 
		
	print(inventory)
	
	for floorData in inventory:
		var floorOption = optionScene.instantiate()
		optionList.add_child(floorOption)
		floorOption.display(floorData)
		floorOption.button.connect("pressed", Callable(self, "selectItem").bind([floorData]))


func _on_wall_button_pressed():
	optionsPanel.show()

func selectItem(params:Array):
	var selectedItem = params[0] as FloorWallOption
	print(selectedItem)
	#itemSelected.emit(selectedItem)


func _on_close_button_pressed():
	optionsPanel.hide()
