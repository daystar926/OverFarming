extends Button

@onready var panel: TextureRect = $SubViewportContainer/SubViewport/Control/panel
@onready var item_icon: TextureRect = $"SubViewportContainer/SubViewport/Control/item icon"
@onready var name_label: Label = $SubViewportContainer/SubViewport/Control/name_label
@onready var option_label: Label = $SubViewportContainer/SubViewport/Control/option_label

var slot_num: int
var item_data


func _set_item_data(item) -> void:
	item_data = item
	item_icon.texture = item.icon
	name_label.text = str(item.item_name)
	option_label.text = str(item.item_option)

	if item.item_id < 1900:
		panel.texture = preload("res://Assets/images/UI/card 1.png")
	elif item.item_id < 2900:
		panel.texture = preload("res://Assets/images/UI/card 2.png")
	elif item.item_id < 3900:
		panel.texture = preload("res://Assets/images/UI/card 3.png")
	elif item.item_id < 4900:
		panel.texture = preload("res://Assets/images/UI/card 4.png")
	elif item.item_id > 5000:
		panel.texture = preload("res://Assets/images/UI/card 5.png")
