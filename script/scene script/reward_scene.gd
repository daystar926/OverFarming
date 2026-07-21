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
	tween.tween_property(title_ui, "position", Vector2(0, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.4)
	var tween2 = create_tween()
	tween2.tween_interval(0.2)
	tween2.tween_property(inventory_ui, "position", Vector2(0, 0), 0.3)\
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


func _on_reroll_button_pressed() -> void:
	selectable = false
	item_slot_setting()
