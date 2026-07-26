extends Control
@onready var title_ui: Control = $"title ui"
@onready var inventory_ui: Control = $"inventory ui"
@onready var extra_shop_ui: Control = $"extra shop ui"
@onready var grid_container: GridContainer = $"inventory ui/MarginContainer/ScrollContainer/GridContainer"

@onready var synergy_1: Control = $"synergy 1"
@onready var synergy_1_color_mat: ColorRect = $"synergy 1/synergy 1 color mat"
@onready var synergy_1_paper_bag: TextureRect = $"synergy 1/synergy 1 paper bag"
@onready var synergy_1_close_button: TextureButton = $"synergy 1/synergy 1 close button"
@onready var synergy_1_buy_button: TextureButton = $"synergy 1/synergy 1 buy button"
@onready var synergy_1_panel: Control = $"synergy 1/synergy 1 panel"

@onready var synergy_2: Control = $"synergy 2"
@onready var synergy_2_color_mat: ColorRect = $"synergy 2/synergy 2 color mat"
@onready var synergy_2_paper_bag: TextureRect = $"synergy 2/synergy 2 paper bag"
@onready var synergy_2_close_button: TextureButton = $"synergy 2/synergy 2 close button"
@onready var synergy_2_buy_button: TextureButton = $"synergy 2/synergy 2 buy button"
@onready var synergy_2_panel: Control = $"synergy 2/synergy 2 panel"

@onready var synergy_3: Control = $"synergy 3"
@onready var synergy_3_color_mat: ColorRect = $"synergy 3/synergy 3 color mat"
@onready var synergy_3_paper_bag: TextureRect = $"synergy 3/synergy 3 paper bag"
@onready var synergy_3_close_button: TextureButton = $"synergy 3/synergy 3 close button"
@onready var synergy_3_buy_button: TextureButton = $"synergy 3/synergy 3 buy button"
@onready var synergy_3_panel: Control = $"synergy 3/synergy 3 panel"

@onready var skip_select_button: TextureButton = $"skip select button"
@onready var plants_check_button: TextureButton = $"plants check button"
@onready var reroll_button: TextureButton = $"reroll button"

@onready var crystal_amount: Label = $"extra shop ui/crystal amount2"
@onready var reroll_button_label: Label = $"reroll button/reroll button label"

@onready var slot_1: Node2D = $"slot 1"
@onready var slot_2: Node2D = $"slot 2"
@onready var slot_3: Node2D = $"slot 3"
@onready var slots: Array = [
	slot_1, slot_2, slot_3
]
var slot_instances: Array = [null, null, null]
var selected_slot_num = 0 # 0이면 스킵할거냐 질문, 1, 2, 3, 이면 slot_instance 쟤들 적용 
var selectable = false

var drawn_item_ids: Array = []
func _ready() -> void:
	inven_refresh()
	crystal_changed()
	spawn_tween()

func _process(delta: float) -> void:
	pass

func crystal_changed():
	crystal_amount.text = str(Global.format_with_commas(Global.crystal)) + " 개"

func spawn_tween():
	var tween = create_tween()
	tween.tween_property(title_ui, "position", Vector2(0, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.4)
	var tween2 = create_tween()
	tween2.tween_interval(0.2)
	tween2.tween_property(inventory_ui, "position", Vector2(0, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(skip_select_button, "position", Vector2(515, 881), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(plants_check_button, "position", Vector2(104, 881), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(reroll_button, "position", Vector2(928, 881), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween3 = create_tween()
	tween3.tween_interval(0.4)
	tween3.tween_property(extra_shop_ui, "position", Vector2(0, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): item_slot_setting())

func item_slot_setting():
	slot_instances = [null, null, null]
	drawn_item_ids.clear()
	var tween = create_tween()
	tween.tween_callback(func():item_slot_setting1())
	tween.tween_interval(0.15)
	tween.tween_callback(func():item_slot_setting2())
	tween.tween_interval(0.15)
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
	1: {1: 90.0, 2: 8.0, 3: 1.5, 4: 0.5},
	2: {1: 84.0, 2: 11.75, 3: 3.0, 4: 1.25},
	3: {1: 78.0, 2: 15.5, 3: 4.5, 4: 2.0},
	4: {1: 72.0, 2: 19.25, 3: 6.0, 4: 2.75},
	5: {1: 66.0, 2: 23.0, 3: 7.5, 4: 3.5},
	6: {1: 60.0, 2: 26.75, 3: 9.0, 4: 4.25},
	7: {1: 54.0, 2: 30.5, 3: 10.5, 4: 5.0},
	8: {1: 48.0, 2: 34.25, 3: 12.0, 4: 5.75},
	9: {1: 42.0, 2: 38.0, 3: 13.5, 4: 6.5},
	10: {1: 36.0, 2: 41.75, 3: 15.0, 4: 7.25},
	11: {1: 30.0, 2: 45.5, 3: 16.5, 4: 8.0},
	12: {1: 24.0, 2: 49.25, 3: 18.0, 4: 8.75},
	13: {1: 18.0, 2: 53.0, 3: 19.5, 4: 9.5},
	14: {1: 12.0, 2: 56.75, 3: 21.0, 4: 10.25},
	15: {1: 6.0, 2: 60.5, 3: 22.5, 4: 11.0},
	16: {1: 0.0, 2: 64.25, 3: 24.0, 4: 11.75},
	17: {1: 0.0, 2: 58.25, 3: 28.0, 4: 13.75},
	18: {1: 0.0, 2: 52.25, 3: 32.0, 4: 15.75},
	19: {1: 0.0, 2: 46.25, 3: 36.0, 4: 17.75},
	20: {1: 0.0, 2: 40.25, 3: 40.0, 4: 19.75},
	21: {1: 0.0, 2: 34.25, 3: 44.0, 4: 21.75},
	22: {1: 0.0, 2: 28.25, 3: 48.0, 4: 23.75},
	23: {1: 0.0, 2: 22.25, 3: 52.0, 4: 25.75},
	24: {1: 0.0, 2: 16.25, 3: 56.0, 4: 27.75},
	25: {1: 0.0, 2: 10.25, 3: 60.0, 4: 29.75},
	26: {1: 0.0, 2: 4.25, 3: 64.0, 4: 31.75},
	27: {1: 0.0, 2: 0.0, 3: 65.08, 4: 34.92},
	28: {1: 0.0, 2: 0.0, 3: 59.08, 4: 40.92},
	29: {1: 0.0, 2: 0.0, 3: 53.08, 4: 46.92},
	30: {1: 0.0, 2: 0.0, 3: 47.08, 4: 52.92},
}

# 레어도별 아이템 ID 목록
var rarity_item_pool: Dictionary = {
	1: [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009,
		1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018],
	2: [2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009,
		2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018],
	3: [3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009, 3010],
	4: [4001],
}


func get_random_item_id() -> int:
	for attempt in range(30):
		var rarity: int = _get_random_rarity(Global.reward_level)
		var item_id: int = _get_random_item_by_rarity(rarity)
		if item_id != -1:
			drawn_item_ids.append(item_id)
			return item_id

	# 30회 안에 못 뽑았을 때의 예비 처리
	for rarity in rarity_item_pool.keys():
		for id in rarity_item_pool[rarity]:
			if not drawn_item_ids.has(id):
				drawn_item_ids.append(id)
				return id

	return -1


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
	var available: Array = []
	for id in pool:
		if not drawn_item_ids.has(id):
			available.append(id)

	if available.is_empty():
		return -1

	return available[randi() % available.size()]


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
	
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_COMMA):
		return
	if Input.is_key_pressed(KEY_PERIOD):
		return

signal reward_exit

func exit_tween():
	var tween = create_tween()
	tween.tween_property(title_ui, "position", Vector2(0, -300), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.6)
	var tween2 = create_tween()
	tween2.tween_interval(0.2)
	tween2.tween_property(inventory_ui, "position", Vector2(700, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(skip_select_button, "position", Vector2(515, 1100), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(plants_check_button, "position", Vector2(104, 1100), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween2.parallel().tween_property(reroll_button, "position", Vector2(928, 1100), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween3 = create_tween()
	tween3.tween_interval(0.3)
	tween3.tween_property(extra_shop_ui, "position", Vector2(700, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween4 = create_tween()
	tween4.tween_interval(0.4)
	tween4.tween_property(slot_1, "position", Vector2(-1000, 321), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween4.parallel().tween_property(slot_2, "position", Vector2(-800, 321), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween4.parallel().tween_property(slot_3, "position", Vector2(-600, 321), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	var tween5 = create_tween()
	tween5.tween_interval(0.4)
	tween5.tween_property(skip_select_button, "position", Vector2(515, 1200), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween5.parallel().tween_property(plants_check_button, "position", Vector2(104, 1200), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween5.parallel().tween_property(reroll_button, "position", Vector2(928, 1200), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): reward_exit.emit())
	tween.tween_callback(func(): queue_free())



func synergy_1_show_tween():
	synergy_1_color_mat.color = Color(0,0,0,0)
	synergy_1_paper_bag.scale = Vector2(0, 0)
	synergy_1_close_button.scale = Vector2(0, 0)
	synergy_1_buy_button.scale = Vector2(0, 0)
	synergy_1_panel.position = Vector2(-700, 431)
	synergy_1.visible = true
	var tween = create_tween()
	tween.tween_property(synergy_1_color_mat, "color", Color(0,0,0,0.8), 0.5)
	tween.parallel().tween_property(synergy_1_paper_bag, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_1_close_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.45)
	tween.parallel().tween_property(synergy_1_buy_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.parallel().tween_property(synergy_1_panel, "position", Vector2(60, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.tween_callback(func():
		synergy_1_buy_button.mouse_filter = Control.MOUSE_FILTER_STOP
		synergy_1_close_button.mouse_filter = Control.MOUSE_FILTER_STOP
		)

func synergy_1_hide_tween():
	synergy_1_buy_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	synergy_1_close_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween = create_tween()
	
	tween.tween_property(synergy_1_paper_bag, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_1_close_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_1_buy_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.2)
	tween.parallel().tween_property(synergy_1_panel, "position", Vector2(-700, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_1_color_mat, "color", Color(0,0,0,0), 0.5)\
		.set_delay(0.6)
	tween.tween_callback(func(): synergy_1.visible = false)

func synergy_2_show_tween():
	synergy_2_color_mat.color = Color(0,0,0,0)
	synergy_2_paper_bag.scale = Vector2(0, 0)
	synergy_2_close_button.scale = Vector2(0, 0)
	synergy_2_buy_button.scale = Vector2(0, 0)
	synergy_2_panel.position = Vector2(-700, 431)
	synergy_2.visible = true
	var tween = create_tween()
	tween.tween_property(synergy_2_color_mat, "color", Color(0,0,0,0.8), 0.5)
	tween.parallel().tween_property(synergy_2_paper_bag, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_2_close_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.45)
	tween.parallel().tween_property(synergy_2_buy_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.parallel().tween_property(synergy_2_panel, "position", Vector2(60, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.tween_callback(func():
		synergy_2_buy_button.mouse_filter = Control.MOUSE_FILTER_STOP
		synergy_2_close_button.mouse_filter = Control.MOUSE_FILTER_STOP
		)

func synergy_2_hide_tween():
	synergy_2_buy_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	synergy_2_close_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween = create_tween()
	
	tween.tween_property(synergy_2_paper_bag, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_2_close_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_2_buy_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.2)
	tween.parallel().tween_property(synergy_2_panel, "position", Vector2(-700, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_2_color_mat, "color", Color(0,0,0,0), 0.5)\
		.set_delay(0.6)
	tween.tween_callback(func(): synergy_2.visible = false)
	
func synergy_3_show_tween():
	synergy_3_color_mat.color = Color(0,0,0,0)
	synergy_3_paper_bag.scale = Vector2(0, 0)
	synergy_3_close_button.scale = Vector2(0, 0)
	synergy_3_buy_button.scale = Vector2(0, 0)
	synergy_3_panel.position = Vector2(-700, 431)
	synergy_3.visible = true
	var tween = create_tween()
	tween.tween_property(synergy_3_color_mat, "color", Color(0,0,0,0.8), 0.5)
	tween.parallel().tween_property(synergy_3_paper_bag, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_3_close_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.45)
	tween.parallel().tween_property(synergy_3_buy_button, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.parallel().tween_property(synergy_3_panel, "position", Vector2(60, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.6)
	tween.tween_callback(func():
		synergy_3_buy_button.mouse_filter = Control.MOUSE_FILTER_STOP
		synergy_3_close_button.mouse_filter = Control.MOUSE_FILTER_STOP
		)

func synergy_3_hide_tween():
	synergy_3_buy_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	synergy_3_close_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween = create_tween()
	
	tween.tween_property(synergy_3_paper_bag, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_3_close_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(synergy_3_buy_button, "scale", Vector2(0, 0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.2)
	tween.parallel().tween_property(synergy_3_panel, "position", Vector2(-700, 431), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(0.3)
	tween.parallel().tween_property(synergy_3_color_mat, "color", Color(0,0,0,0), 0.5)\
		.set_delay(0.6)
	tween.tween_callback(func(): synergy_3.visible = false)


func _on_synergy_1_pressed() -> void:
	synergy_1_show_tween()

func _on_synergy_1_close_button_pressed() -> void:
	synergy_1_hide_tween()


func _on_synergy_2_pressed() -> void:
	synergy_2_show_tween()

func _on_synergy_2_close_button_pressed() -> void:
	synergy_2_hide_tween()


func _on_synergy_3_pressed() -> void:
	synergy_3_show_tween()

func _on_synergy_3_close_button_pressed() -> void:
	synergy_3_hide_tween()


func _on_skip_select_button_pressed() -> void:
	exit_tween()


var reroll_chance = 2
func _on_reroll_button_pressed() -> void:
	if reroll_chance > 0:
		reroll_chance -= 1
		reroll_button_label.text = "새로고침 (" + str(reroll_chance) + ")"
		selectable = false
		item_slot_setting()
		

func _on_synergy_1_buy_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()


func _on_synergy_2_buy_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()

func _on_synergy_3_buy_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()
