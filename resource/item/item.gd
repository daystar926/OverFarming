class_name ItemResource
extends Resource

@export var item_id: int
@export var item_name: String = ""
@export_multiline var item_option: String = ""
@export_multiline var discription: String = ""
@export var icon: Texture2D
@export var rarity: Rarity = Rarity.COMMON


enum Rarity {
	COMMON,
	RARE,
	EPIC,
	UNIQUE,
	SYNERGY,
}

func apply():
	Global.apply_item(item_id)
