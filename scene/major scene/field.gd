extends Control
@onready var slots: Control = $"../UI layer/slots"
@onready var main_game: Control = $".."
@onready var grid: GridContainer = $GridContainer
@onready var actual_field: Node = $"../actual field"

var plants_list: Dictionary = {
	1: preload("res://scene/plants/rice.tscn"),
	2: preload("res://scene/plants/wheat.tscn"),
	3: preload("res://scene/plants/cabbage.tscn")
}

func _ready() -> void:
	for field in grid.get_children():
		for child in field.get_children():
			if child is Area2D:
				child.area_entered.connect(_on_field_area_entered.bind(field))

func _on_field_area_entered(area: Area2D, field: Control) -> void:
	var crop_id: int = slots.current_selected
	var raw_index: int = int(field.name.substr(6))
	var grid_pos := Vector2i((raw_index - 1) % 8, (raw_index - 1) / 8)

	# 이미 심어진 칸이면 무시
	if Global.is_occupied(grid_pos):
		return
	# 남은 모종 없으면 무시
	if Global.get_sa(crop_id) <= 0:
		return

	Global.use_sa(crop_id, 1)
	print(Global.get_sa(crop_id))

	var pixel_pos := Vector2(grid_pos.x * 128 + 64, grid_pos.y * 128 + 64 + 5)
	var plant = plants_check()
	plant.position = pixel_pos
	plant.set("crop_id", crop_id)
	plant.set("grid_pos", grid_pos)
	actual_field.add_child(plant)

	print(grid_pos)
	Global.set_occupied(grid_pos, plant)

func plants_check():
	var plants_num = slots.current_selected
	var plants_instance = plants_list[plants_num].instantiate()
	return plants_instance
