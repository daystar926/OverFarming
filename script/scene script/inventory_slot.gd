extends Control

@onready var texture: TextureRect = $TextureRect
var item_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item(item):
	item_data = item
	if item_data.icon != null:
		texture.texture = item_data.icon
	
