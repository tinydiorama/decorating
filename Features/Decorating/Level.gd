extends Node2D

@onready var placeableArea = $PlaceableArea

func _ready() -> void:
	#set appropriate placeableArea for each level
	ItemPlacer.world = placeableArea
