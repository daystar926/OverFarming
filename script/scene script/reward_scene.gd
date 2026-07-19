extends Control
@onready var title_ui: Control = $"title ui"
@onready var inventory_ui: Control = $"inventory ui"
@onready var extra_shop_ui: Control = $"extra shop ui"
@onready var grid_container: GridContainer = $"inventory ui/MarginContainer/ScrollContainer/GridContainer"

@onready var slot_1: Node2D = $"slot 1"
@onready var slot_2: Node2D = $"slot 2"
@onready var slot_3: Node2D = $"slot 3"
@onready var slots: Array = [
	slot_1, slot_2, slot_3
]
var slot_instances: Array = [null, null, null]
var selected_slot_num = 0 # 0이면 스킵할거냐 질문, 1, 2, 3, 이면 slot_instance 쟤들 적용 
var selectable = false
func _ready() -> void:
	inven_refresh()
	spawn_tween()

func _process(delta: float) -> void:
	pass

func spawn_tween():
	var tween = create_tween()
	tween.tween_property(title_ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.2)
	var tween2 = create_tween()
	tween2.tween_interval(0.3)
	tween2.tween_property(inventory_ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween3 = create_tween()
	tween3.tween_interval(0.6)
	tween3.tween_property(extra_shop_ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): item_slot_setting())

func item_slot_setting():
	slot_instances = [null, null, null]
	var tween = create_tween()
	tween.tween_callback(func():item_slot_setting1())
	tween.tween_interval(0.3)
	tween.tween_callback(func():item_slot_setting2())
	tween.tween_interval(0.3)
	tween.tween_callback(func():item_slot_setting3())
	tween.tween_callback(func():selectable = true)

func item_slot_setting1() -> void:
	for child in slot_1.get_children():
		child.queue_free()

	var slot_ins = preload("res://scene/item card.tscn").instantiate()
	var item_id: int = get_random_item_id()
	var item_data: ItemResource = Global.get_item_by_id(item_id)
	print(item_data)
	if item_data == null:
		print("아이템 데이터를 찾을 수 없습니다: %d" % item_id)
		return
	
	slots[0].add_child(slot_ins)
	slot_ins.set_item(item_data)
	slot_ins.slot_num = 0
	slot_ins.selected.connect(_on_slot_selected)
	slot_ins.disappeared.connect(grid_refresh)
	slot_instances[0] = slot_ins
	
func item_slot_setting2() -> void:
	for child in slot_2.get_children():
		child.queue_free()

	var slot_ins = preload("res://scene/item card.tscn").instantiate()
	var item_id: int = get_random_item_id()
	var item_data: ItemResource = Global.get_item_by_id(item_id)
	print(item_data)
	if item_data == null:
		print("아이템 데이터를 찾을 수 없습니다: %d" % item_id)
		return
	
	slots[1].add_child(slot_ins)
	slot_ins.set_item(item_data)
	slot_ins.slot_num = 1
	slot_ins.selected.connect(_on_slot_selected)
	slot_ins.disappeared.connect(grid_refresh)
	slot_instances[1] = slot_ins

func item_slot_setting3() -> void:
	for child in slot_3.get_children():
		child.queue_free()

	var slot_ins = preload("res://scene/item card.tscn").instantiate()
	var item_id: int = get_random_item_id()
	var item_data: ItemResource = Global.get_item_by_id(item_id)
	print(item_data)
	if item_data == null:
		print("아이템 데이터를 찾을 수 없습니다: %d" % item_id)
		return
	
	slots[2].add_child(slot_ins)
	slot_ins.set_item(item_data)
	slot_ins.slot_num = 2
	slot_ins.selected.connect(_on_slot_selected)
	slot_ins.disappeared.connect(grid_refresh)
	slot_instances[2] = slot_ins
	
func _on_slot_selected(slot_num: int) -> void:
	if not selectable:
		return
	selectable = false

	for i in range(slot_instances.size()):
		if i == slot_num:
			slot_instances[i].play_selected()
		else:
			slot_instances[i].cancel_selection()

const RARITY_WEIGHTS: Dictionary = {
	1: {1: 90, 2: 8, 3: 1.5, 4: 0.5},
	2: {1: 80, 2: 17, 3: 2, 4: 1},
	3: {1: 70, 2: 25, 3: 3, 4: 2},
	4: {1: 60, 2: 30, 3: 7, 4: 3},
	5: {1: 50, 2: 30, 3: 15, 4: 5},
}

# 레어도별 아이템 ID 목록
var rarity_item_pool: Dictionary = {
	1: [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018],
	2: [2001, 2002, 2003, 2004],
	3: [3001],
	4: [4001],
}


func get_random_item_id() -> int:
	var rarity: int = _get_random_rarity(Global.reward_level)
	var item_id: int = _get_random_item_by_rarity(rarity)
	return item_id


func _get_random_rarity(reward_level: int) -> int:
	var weights: Dictionary = RARITY_WEIGHTS.get(reward_level, RARITY_WEIGHTS[1])

	var total_weight: int = 0
	for weight in weights.values():
		total_weight += weight

	var roll: int = randi_range(1, total_weight)
	var cumulative: int = 0

	for rarity in weights.keys():
		cumulative += weights[rarity]
		if roll <= cumulative:
			return rarity

	return weights.keys()[0]


func _get_random_item_by_rarity(rarity: int) -> int:
	var pool: Array = rarity_item_pool.get(rarity, [])
	if pool.is_empty():
		push_error("해당 레어도의 아이템 풀이 비어있습니다: %d" % rarity)
		return -1

	return pool[randi() % pool.size()]


func _on_debug_button_1_pressed() -> void:
	selectable = false
	item_slot_setting()

func inven_refresh():
	for child in grid_container.get_children():
		child.queue_free()

	for item in Global.item_inventory:
		var slot = preload("res://scene/inventory_slot.tscn").instantiate()
		grid_container.add_child(slot)
		slot.set_item(item)

func grid_refresh():
	for child in grid_container.get_children():
		child.queue_free()

	for item in Global.item_inventory:
		var slot = preload("res://scene/inventory_slot.tscn").instantiate()
		grid_container.add_child(slot)
		slot.set_item(item)
		
	exit_tween()
	
signal reward_exit
func exit_tween():
	var tween = create_tween()
	tween.tween_property(title_ui, "position", Vector2(0, -300), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.2)
	var tween2 = create_tween()
	tween2.tween_interval(0.3)
	tween2.tween_property(inventory_ui, "position", Vector2(700, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween3 = create_tween()
	tween3.tween_interval(0.6)
	tween3.tween_property(extra_shop_ui, "position", Vector2(700, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): reward_exit.emit())
	tween.tween_callback(func(): queue_free())
