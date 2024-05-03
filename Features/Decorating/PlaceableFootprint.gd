class_name PlaceableFootprint extends Area2D

signal placement_eligibility_changed(eligible:bool)

@export var surfaceOrWallCollision:int
@export var collisionRequired:int

var allowedTerrain:int = 224
var offendingTiles:int = 0

var placementEligible:bool = true:
	get:
		return placementEligible
	set(newValue):
		placementEligible = newValue
		emit_signal("placement_eligibility_changed", newValue)
		
func _ready() -> void:
	setActive(false)
	
func setActive(active:bool) -> void:
	visible = active
	
func processCollisions() -> void:
	print(get_overlapping_areas())
	var collidingArea = ! get_overlapping_areas().filter(
		func(area:Area2D):
			print(area.collision_layer)
			if ( area.collision_layer == 16 || (area.collision_layer == surfaceOrWallCollision && ( surfaceOrWallCollision == 2 ||  area.collision_layer == 3)) ):
				return true
			elif ( collisionRequired == 4 || collisionRequired == 5 || area.collision_layer == 4 || area.collision_layer == 5):
				return false
			else:
				return area.get_parent() != get_parent()
	).is_empty()
	
	var collidingTile = offendingTiles > 0
	placementEligible = ! collidingArea && ! collidingTile
	
func processTileCollision() -> void:
	pass
	
func processTileMapCollision(tilemap:TileMap, body_rid:RID, exited:bool) -> void:
	var collidedTileCoords = tilemap.get_coords_for_body_rid(body_rid)
	
	for index in tilemap.get_layers_count():
		var tileData = tilemap.get_cell_tile_data(index, collidedTileCoords)
		if ( ! tileData is TileData ):
			continue
			
		var terrainMask = tileData.get_custom_data_by_layer_id(2)
		if ( ( allowedTerrain & terrainMask ) == 0 ):
			if exited:
				offendingTiles -= 1
			else:
				offendingTiles += 1
		break
	
	processCollisions()
	
func _on_area_entered(_area:Area2D) -> void:
	processCollisions()

func _on_area_exited(_area):
	processCollisions()
