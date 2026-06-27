extends Control

@onready var slots: Control = $"../UI layer/slots"
@onready var main_game: Control = $".."
@onready var grid: GridContainer = $GridContainer

var plants_list: Dictionary = {
	1: preload("res://scene/plants/rice.tscn")
}

func _ready() -> void:
	for field in grid.get_children():
		for child in field.get_children():
			if child is Area2D:
				child.area_entered.connect(_on_field_area_entered.bind(field))

func _on_field_area_entered(area: Area2D, field: Control) -> void:
	var crop_id: int = slots.current_selected
	# 이미 식물이 있으면 무시 (Area2D 1개 + 식물 1개 = 2개)
	if field.get_child_count() > 1:
		return
	# 남은 모종 없으면 무시
	if Global.get_sa(crop_id) <= 0:
		return
	# 모종 1개 차감
	Global.use_sa(crop_id, 1)
	print(Global.get_sa(crop_id))
	var plant = plants_check()
	plant.position = field.size / 2
	plant.position.y -= 15
	field.add_child(plant)

func plants_check():
	var plants_num = slots.current_selected
	var plants_instance = plants_list[plants_num].instantiate()
	return plants_instance
