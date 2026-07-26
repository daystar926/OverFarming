extends Control

@onready var texture: TextureRect = $TextureRect
var item_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("인벤 개수: ", Global.item_inventory.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item(item):
	texture.texture = item.icon
	
