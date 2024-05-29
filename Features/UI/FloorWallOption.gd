extends HBoxContainer

@onready var button = %FloorWallOptionButton
@onready var nameNode = %FloorWallLabel

var floorWallData:FloorWallOption

func display(floorWallOption:FloorWallOption):
	nameNode.text = floorWallOption.name
	button.texture_normal = floorWallOption.floorWallTexture
	floorWallData = floorWallOption
