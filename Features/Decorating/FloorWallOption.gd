class_name FloorWallOption
extends Resource

enum FloorWall {
  FLOOR,
	WALL
}

@export var id:String = ""
@export var name:String = ""
@export var description:String = ""
@export var tags:Array[String] = []
@export var floorWallTexture:Texture2D
@export var defaultColor:Color = Color.WHITE
@export var floorOrWall:FloorWall
