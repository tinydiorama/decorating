extends Node2D

@export var world:Node2D = self

var isActive:bool
var isDragging:bool

var itemToPlace:PlaceableItem:
	get:
		return itemToPlace
	set(new_value):
		itemToPlace = new_value
			
var previewInstance:Placeable
var isNewObject:bool

func _ready() -> void:
	isActive = false
	isNewObject = false
	
func _physics_process(_delta:float) -> void:
	if ( previewInstance != null && isDragging && isActive ):
		var mousePosition = get_global_mouse_position()
		var roundedPosition = Vector2(int(round(mousePosition.x)), int(round(mousePosition.y)))
		previewInstance.global_position = roundedPosition
		
func _input(_event) -> void:
	# can also return if you've paused the game
	if ( previewInstance == null ):
		return

func newObjectCreated() -> void:
	isNewObject = true
	
	var droppedScene = load(itemToPlace.placeableItemScenePath)
	var droppedInstance = droppedScene.instantiate() as Placeable
	#droppedInstance.position = previewInstance.position
	droppedInstance.setCollisionEnabled(true)
	world.add_child(droppedInstance)
	
	previewInstance = droppedInstance

	previewInstance.isActive = true
	setActive()

func createPlacementPreview() -> void:
	if ( itemToPlace == null ):
		return
		
	previewInstance.setCollisionEnabled(false)
	previewInstance.previewing = true
	
func setActive() -> void:
	previewInstance.previewing = true
	previewInstance.showActiveUI()
	await get_tree().create_timer(0.3).timeout
	isActive = true

func setInactive() -> void:
	if ( previewInstance != null ):
		previewInstance.hideActiveUI()
	isActive = false
	
func clearPreview() -> void:
	setInactive()
	if ( previewInstance == null ):
		return
	
	previewInstance.queue_free()
	previewInstance = null
		
func placeItem() -> void:
	if ( previewInstance == null ):
		return
		
	if ( ! previewInstance.canPlace ):
		return
		
	if ( previewInstance != null ):
		previewInstance.hideActiveUI()
		
	previewInstance.setCollisionEnabled(true)
	previewInstance.previewing = false
	
	
	var droppedScene = load(itemToPlace.placeableItemScenePath)
	var droppedInstance = droppedScene.instantiate() as Placeable
	droppedInstance.position = previewInstance.position
	droppedInstance.setCollisionEnabled(true)
	world.add_child(droppedInstance)
		
	itemToPlace = null
	clearPreview()
	
	setInactive()
	
	# can save scene here
