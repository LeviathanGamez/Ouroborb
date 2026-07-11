extends Resource
class_name tile_types


enum TileTypes{
	NORMAL,
	GOLD,
	DIAMOND
}
@export var type : TileTypes
@export var value : int
@export var tile_type_mult: int
@export var texture : Texture2D
