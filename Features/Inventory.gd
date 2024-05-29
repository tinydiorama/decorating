extends Node

var inventory:Array[PlaceableItem] = []
var floorOptions:Array[FloorWallOption] = []
var wallOptions:Array[FloorWallOption] = []

func addItem(item:PlaceableItem):
	if ( ! inventory.has(item) ):
		inventory.append(item)

func removeItem(item:PlaceableItem):
	if ( inventory.has(item) ):
		inventory.erase(item)

func getInventory() -> Array[PlaceableItem]:
	return inventory

func getFloorOptions() -> Array:
	return floorOptions
	
func addFloorOption(floorOption:FloorWallOption):
	if ( ! floorOptions.has(floorOption) ):
		floorOptions.append(floorOption)
		
func removeFloor(floorOption:FloorWallOption):
	if ( floorOptions.has(floorOption) ):
		floorOptions.erase(floorOption)

func getWallOptions() -> Array:
	return wallOptions
	
func addWallOption(wallOption:FloorWallOption):
	if ( ! wallOptions.has(wallOption) ):
		wallOptions.append(wallOption)
		
func removeWall(wallOption:FloorWallOption):
	if ( wallOptions.has(wallOption) ):
		wallOptions.erase(wallOption)
