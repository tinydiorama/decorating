class_name Placeable extends StaticBody2D

const shaderMaterial = preload("res://Features/Decorating/Shaders/PlaceableShaderMaterial.tres")
const shaderParamPreview = "PREVIEW"
const shaderParamPlaceable = "PLACEABLE"

@export var placeableItem:PlaceableItem = null

@onready var placeableFootprint:PlaceableFootprint = $PlaceableFootprint
@onready var sprite:Sprite2D = $SpriteColor
@onready var collisionShape:CollisionPolygon2D = %GrippyCollision
@onready var controlsPanel = %ControlsPanel

#Color Picker
@onready var colorPickerPanel = %ColorPickerPopup
@onready var colorPicker = %ColorPicker
@onready var editColorButton = %EditColor

var isActive:bool = false
var draggable:bool = false
var isFlipped:bool = false
var currentColor:Color

var previewing:bool:
	get:
		return previewing
	set(newValue):
		previewing = newValue
		updateShader()
		
var canPlace:bool = true:
	get:
		return canPlace
	set(newValue):
		canPlace = newValue
		updateShader()
		
func _ready() -> void:
	sprite.self_modulate = placeableItem.defaultColor
	currentColor = placeableItem.defaultColor
	setupShader()
	
func setupShader() -> void:
	sprite.material = shaderMaterial.duplicate()
	updateShader()
	
func updateShader() -> void:
	if ( sprite.material == null ):
		return
	
	sprite.material.set_shader_parameter(shaderParamPreview, previewing)
	sprite.material.set_shader_parameter(shaderParamPlaceable, canPlace)

func setCollisionEnabled(enabled:bool) -> void:
	call_deferred("deferredSetCollisionEnabled", enabled)
	
func deferredSetCollisionEnabled(enabled:bool) -> void:
	collisionShape.disabled = ! enabled

func _on_placeable_footprint_placement_eligibility_changed(eligible):
	canPlace = eligible

func showActiveUI():
	controlsPanel.show()
	colorPicker.set_pick_color(currentColor)
	editColorButton.self_modulate = currentColor
	
func hideActiveUI():
	controlsPanel.hide()

func _on_input_event(_viewport, event, _shape_idx):
	if ( event is InputEventMouseButton ):
		if ( event.button_index == MOUSE_BUTTON_LEFT && event.pressed ):
			if ( isActive == false || (ItemPlacer.itemToPlace != null && ItemPlacer.itemToPlace != placeableItem)): #another node is already active
				ItemPlacer.placeItem()
			#TODO: check to make sure there's not a different object active
			#if there is, be sure to place it before allowing a new instance
			#ItemPlacer.placeItem()

			ItemPlacer.previewInstance = self
			ItemPlacer.itemToPlace = placeableItem
			isActive = true
			ItemPlacer.setActive()
			
func _process(_delta):
	if ( draggable && isActive ):
		if ( ItemPlacer.isActive == false || (ItemPlacer.itemToPlace != null && ItemPlacer.itemToPlace != placeableItem)): #another node is already active
			return
			
		if ( Input.is_action_pressed("place_item") ):
			ItemPlacer.isDragging = true
		elif ( Input.is_action_just_released("place_item") ):
			ItemPlacer.isDragging = false

func _on_mouse_entered():
	if ( ! ItemPlacer.isDragging ):
		draggable = true
	pass


func _on_mouse_exited():
	if ( ! ItemPlacer.isDragging ):
		draggable = false
	pass # Replace with function body.


func _on_confirm_pressed():
	isActive = false
	ItemPlacer.placeItem()

func _on_delete_pressed():
	ItemPlacer.clearPreview()

func _on_rotate_pressed():
	isFlipped = ! isFlipped
	flip()
	
func flip():
	if ( isFlipped ):
		placeableFootprint.scale.x = -1
		sprite.scale.x = -1
		collisionShape.scale.x = -1
	else:
		placeableFootprint.scale.x = 1
		sprite.scale.x = 1
		collisionShape.scale.x = 1


func _on_edit_color_pressed():
	colorPickerPanel.show()


func _on_color_picker_color_changed(color):
	editColorButton.self_modulate = color
	sprite.self_modulate = color
	currentColor = color
