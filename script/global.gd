extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_all_items()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
# ================ 게임 결과 변수 ===============
var play_time: float = 0
var total_plants: int = 0
var total_gold = 0

var crystal = 0
var current_gold = 100
var current_ticket = 0
var reward_level = 10
### bgt = base grow time 기본 성장 시간
### gt = grow time 수확 시간
### fa = farming amount 가격
### sa = seed amount 모종 갯수
### 성장시간은 bgt
### 수확시간은 gt
### 아이템 보상 희귀도 레벨은 reward_level
### 추가 수확은 da increase
### 추사 수확 확률은 da chance
const GT_BASE_RICE = 90
const GT_BASE_WHEAT = 60
const GT_BASE_CABBAGE = 30
const GT_BASE_GRAPE = 30
const BGT_BASE_GRAPE = 30
const GT_BASE_ONION = 50
const GT_BASE_CORN = 50
const BGT_BASE_CORN = 50
const GT_BASE_BEAN = 30
const BGT_BASE_BEAN = 20
const GT_BASE_PUMPKIN = 90
const GT_BASE_TOMATO = 40
const BGT_BASE_TOMATO = 40

const FA_BASE_RICE = 10
const FA_BASE_WHEAT = 7
const FA_BASE_CABBAGE = 3
const FA_BASE_GRAPE = 3
const FA_BASE_ONION = 7
const FA_BASE_CORN = 5
const FA_BASE_BEAN = 2
const FA_BASE_TOMATO = 4
const FA_BASE_PUMPKIN = 16

const DA_BASE_RICE = 1
const DA_BASE_WHEAT = 1
const DA_BASE_CABBAGE = 1
const DA_BASE_GRAPE = 1
const DA_BASE_ONION = 1
const DA_BASE_CORN = 1
const DA_BASE_BEAN = 1
const DA_BASE_PUMPKIN = 1
const DA_BASE_TOMATO = 1

var additional_move_speed = 0
var decrease_move_speed = 0
var base_move_speed = 400
var total_move_speed = 0
var gt_reduce_percent_all_plants = 0
var gt_reduce_all_plants = 0
var gt_increase_percent_all_plants = 0
var gt_increase_all_plants = 0
var fa_increase_percent_all_plants = 0

### DA
# rice
var da_chance_rice = 0
var da_increase_rice = 0

# wheat
var da_chance_wheat = 0
var da_increase_wheat = 0

# cabbage
var da_chance_cabbage = 0
var da_increase_cabbage = 0

# grape
var da_chance_grape = 0
var da_increase_grape = 0

# onion
var da_chance_onion = 0
var da_increase_onion = 0

# corn
var da_chance_corn = 0
var da_increase_corn = 0

# bean
var da_chance_bean = 0
var da_increase_bean = 0

# pumpkin
var da_chance_pumpkin = 0
var da_increase_pumpkin = 0

# tomato
var da_chance_tomato = 0
var da_increase_tomato = 0

#############

# rice
var gt_reduce_percent_rice = 0
var gt_reduce_rice = 0
var gt_increase_percent_rice = 0
var gt_increase_rice = 0
var fa_increase_percent_rice = 0
var fa_increase_rice = 0
var fa_reduce_percent_rice = 0
var fa_reduce_rice = 0
var sa_add_rice = 0
#var sa_base_rice = 3

# wheat
var gt_reduce_percent_wheat = 0
var gt_reduce_wheat = 0
var gt_increase_percent_wheat = 0
var gt_increase_wheat = 0
var fa_increase_percent_wheat = 0
var fa_increase_wheat = 0
var fa_reduce_percent_wheat = 0
var fa_reduce_wheat = 0
var sa_add_wheat = 0
#var sa_base_wheat = 3

# cabbage
var gt_reduce_percent_cabbage = 0
var gt_reduce_cabbage = 0
var gt_increase_percent_cabbage = 0
var gt_increase_cabbage = 0
var fa_increase_percent_cabbage = 0
var fa_increase_cabbage = 0
var fa_reduce_percent_cabbage = 0
var fa_reduce_cabbage = 0
var sa_add_cabbage = 0
#var sa_base_cabbage = 0

# grape
var gt_reduce_percent_grape = 0
var gt_reduce_grape = 0
var gt_increase_percent_grape = 0
var gt_increase_grape = 0
var fa_increase_percent_grape = 0
var fa_increase_grape = 0
var fa_reduce_percent_grape = 0
var fa_reduce_grape = 0
var sa_add_grape = 0
# grape bgt
var bgt_reduce_percent_grape = 0
var bgt_reduce_grape = 0
var bgt_increase_percent_grape = 0
var bgt_increase_grape = 0
#var sa_base_grape = 0

# onion
var gt_reduce_percent_onion = 0
var gt_reduce_onion = 0
var gt_increase_percent_onion = 0
var gt_increase_onion = 0
var fa_increase_percent_onion = 0
var fa_increase_onion = 0
var fa_reduce_percent_onion = 0
var fa_reduce_onion = 0
var sa_add_onion = 0
#var sa_base_onion = 0

# corn
var gt_reduce_percent_corn = 0
var gt_reduce_corn = 0
var gt_increase_percent_corn = 0
var gt_increase_corn = 0
var fa_increase_percent_corn = 0
var fa_increase_corn = 0
var fa_reduce_percent_corn = 0
var fa_reduce_corn = 0
var sa_add_corn = 0
# corn bgt
var bgt_reduce_percent_corn = 0
var bgt_reduce_corn = 0
var bgt_increase_percent_corn = 0
var bgt_increase_corn = 0
#var sa_base_corn = 0

# bean
var gt_reduce_percent_bean = 0
var gt_reduce_bean = 0
var gt_increase_percent_bean = 0
var gt_increase_bean = 0
var fa_increase_percent_bean = 0
var fa_increase_bean = 0
var fa_reduce_percent_bean = 0
var fa_reduce_bean = 0
var sa_add_bean = 0
# bean bgt
var bgt_reduce_percent_bean = 0
var bgt_reduce_bean = 0
var bgt_increase_percent_bean = 0
var bgt_increase_bean = 0
#var sa_base_bean = 0

# pumpkin
var gt_reduce_percent_pumpkin = 0
var gt_reduce_pumpkin = 0
var gt_increase_percent_pumpkin = 0
var gt_increase_pumpkin = 0
var fa_increase_percent_pumpkin = 0
var fa_increase_pumpkin = 0
var fa_reduce_percent_pumpkin = 0
var fa_reduce_pumpkin = 0
var sa_add_pumpkin = 0
#var sa_base_pumpkin = 0

# tomato
var gt_reduce_percent_tomato = 0
var gt_reduce_tomato = 0
var gt_increase_percent_tomato = 0
var gt_increase_tomato = 0
var fa_increase_percent_tomato = 0
var fa_increase_tomato = 0
var fa_reduce_percent_tomato = 0
var fa_reduce_tomato = 0
var sa_add_tomato = 0
# tomato bgt
var bgt_reduce_percent_tomato = 0
var bgt_reduce_tomato = 0
var bgt_increase_percent_tomato = 0
var bgt_increase_tomato = 0
#var sa_base_tomato = 0

# rice total
var gt_total_rice = 0
var fa_total_rice = 0
var sa_total_rice = 3

# wheat total
var gt_total_wheat = 0
var fa_total_wheat = 0
var sa_total_wheat = 3

# cabbage total
var gt_total_cabbage = 0
var fa_total_cabbage = 0
var sa_total_cabbage = 3

# grape total
var gt_total_grape = 0
var bgt_total_grape = 0
var fa_total_grape = 0
var sa_total_grape = 3

# onion total
var gt_total_onion = 0
var fa_total_onion = 0
var sa_total_onion = 3

# corn total
var gt_total_corn = 0
var bgt_total_corn = 0
var fa_total_corn = 0
var sa_total_corn = 3

# bean total
var gt_total_bean = 0
var bgt_total_bean = 0
var fa_total_bean = 0
var sa_total_bean = 3


# pumpkin total
var gt_total_pumpkin = 0
var fa_total_pumpkin = 0
var sa_total_pumpkin = 3

# tomato total
var gt_total_tomato = 0
var bgt_total_tomato = 0
var fa_total_tomato = 0
var sa_total_tomato = 3

# rice total
var da_total_rice = 0

# wheat total
var da_total_wheat = 0

# cabbage total
var da_total_cabbage = 0

# grape total
var da_total_grape = 0

# onion total
var da_total_onion = 0

# corn total
var da_total_corn = 0

# bean total
var da_total_bean = 0

# pumpkin total
var da_total_pumpkin = 0

# tomato total
var da_total_tomato = 0

var da_add_all = 0
var item_reward_chance = 1

const DROP_ITEM_DISTANCE_BASE = 350
var drop_item_distance_increase = 0
var drop_item_distance_decrease = 0
var drop_item_distance_total = 0

signal all_stat_refresh

# 작물 ID로 현재 모종 수 읽기
func get_sa(crop_id: int) -> int:
	match crop_id:
		1:
			return sa_total_rice
		2:
			return sa_total_wheat
		3:
			return sa_total_cabbage
		4:
			return sa_total_grape
		5:
			return sa_total_onion
		6:
			return sa_total_corn
		7:
			return sa_total_bean
		8:
			return sa_total_pumpkin
		9:
			return sa_total_tomato
		_:
			return 0

# 심을 때 — 모종 1개 차감
func use_sa(crop_id: int, amount: int = 1) -> void:
	match crop_id:
		1:
			sa_total_rice -= amount
		2:
			sa_total_wheat -= amount
		3:
			sa_total_cabbage -= amount
		4:
			sa_total_grape -= amount
		5:
			sa_total_onion -= amount
		6:
			sa_total_corn -= amount
		7:
			sa_total_bean -= amount
		8:
			sa_total_pumpkin -= amount
		9:
			sa_total_tomato -= amount

# 회수할 때 — 모종 1개 복구
func add_sa(crop_id: int, amount: int = 1) -> void:
	match crop_id:
		1:
			sa_total_rice += amount
		2:
			sa_total_wheat += amount
		3:
			sa_total_cabbage += amount
		4:
			sa_total_grape += amount
		5:
			sa_total_onion += amount
		6:
			sa_total_corn += amount
		7:
			sa_total_bean += amount
		8:
			sa_total_pumpkin += amount
		9:
			sa_total_tomato += amount

func stat_refresh():
	total_move_speed = clamp(base_move_speed + additional_move_speed - decrease_move_speed, 50, 1000) #(아이템으로 증가 가능한 벨류)
	
# rice
	gt_total_rice = clamp((GT_BASE_RICE + gt_increase_rice - gt_reduce_rice) * \
	clamp((1 + (gt_increase_percent_rice - gt_reduce_percent_rice)/100.0), 0, 5000), 0, 999999)
	fa_total_rice = clamp((FA_BASE_RICE + fa_increase_rice - fa_reduce_rice) * \
	clamp((1 + (fa_increase_percent_rice + fa_increase_percent_all_plants - fa_reduce_percent_rice)/100.0), 0, 5000), 0, 999999)
	
	# wheat
	gt_total_wheat = clamp((GT_BASE_WHEAT + gt_increase_wheat - gt_reduce_wheat) * \
	clamp((1 + (gt_increase_percent_wheat - gt_reduce_percent_wheat)/100.0), 0, 5000), 0, 999999)
	fa_total_wheat = clamp((FA_BASE_WHEAT + fa_increase_wheat - fa_reduce_wheat) * \
	clamp((1 + (fa_increase_percent_wheat + fa_increase_percent_all_plants - fa_reduce_percent_wheat)/100.0), 0, 5000), 0, 999999)
	
	# cabbage
	gt_total_cabbage = clamp((GT_BASE_CABBAGE + gt_increase_cabbage - gt_reduce_cabbage) * \
	clamp((1 + (gt_increase_percent_cabbage - gt_reduce_percent_cabbage)/100.0), 0, 5000), 0, 999999)
	fa_total_cabbage = clamp((FA_BASE_CABBAGE + fa_increase_cabbage - fa_reduce_cabbage) * \
	clamp((1 + (fa_increase_percent_cabbage + fa_increase_percent_all_plants - fa_reduce_percent_cabbage)/100.0), 0, 5000), 0, 999999)
	
	# grape
	gt_total_grape = clamp((GT_BASE_GRAPE + gt_increase_grape - gt_reduce_grape) * \
	clamp((1 + (gt_increase_percent_grape - gt_reduce_percent_grape)/100.0), 0, 5000), 0, 999999)
	bgt_total_grape = clamp((BGT_BASE_GRAPE + bgt_increase_grape - bgt_reduce_grape) * \
	clamp((1 + (bgt_increase_percent_grape - bgt_reduce_percent_grape)/100.0), 0, 5000), 0, 999999)
	fa_total_grape = clamp((FA_BASE_GRAPE + fa_increase_grape - fa_reduce_grape) * \
	clamp((1 + (fa_increase_percent_grape + fa_increase_percent_all_plants - fa_reduce_percent_grape)/100.0), 0, 5000), 0, 999999)
	
	# onion
	gt_total_onion = clamp((GT_BASE_ONION + gt_increase_onion - gt_reduce_onion) * \
	clamp((1 + (gt_increase_percent_onion - gt_reduce_percent_onion)/100.0), 0, 5000), 0, 999999)
	fa_total_onion = clamp((FA_BASE_ONION + fa_increase_onion - fa_reduce_onion) * \
	clamp((1 + (fa_increase_percent_onion + fa_increase_percent_all_plants - fa_reduce_percent_onion)/100.0), 0, 5000), 0, 999999)
	
	# corn
	gt_total_corn = clamp((GT_BASE_CORN + gt_increase_corn - gt_reduce_corn) * \
	clamp((1 + (gt_increase_percent_corn - gt_reduce_percent_corn)/100.0), 0, 5000), 0, 999999)
	bgt_total_corn = clamp((BGT_BASE_CORN + bgt_increase_corn - bgt_reduce_corn) * \
	clamp((1 + (bgt_increase_percent_corn - bgt_reduce_percent_corn)/100.0), 0, 5000), 0, 999999)
	fa_total_corn = clamp((FA_BASE_CORN + fa_increase_corn - fa_reduce_corn) * \
	clamp((1 + (fa_increase_percent_corn + fa_increase_percent_all_plants - fa_reduce_percent_corn)/100.0), 0, 5000), 0, 999999)
	
	# bean
	gt_total_bean = clamp((GT_BASE_BEAN + gt_increase_bean - gt_reduce_bean) * \
	clamp((1 + (gt_increase_percent_bean - gt_reduce_percent_bean)/100.0), 0, 5000), 0, 999999)
	bgt_total_bean = clamp((BGT_BASE_BEAN + bgt_increase_bean - bgt_reduce_bean) * \
	clamp((1 + (bgt_increase_percent_bean - bgt_reduce_percent_bean)/100.0), 0, 5000), 0, 999999)
	fa_total_bean = clamp((FA_BASE_BEAN + fa_increase_bean - fa_reduce_bean) * \
	clamp((1 + (fa_increase_percent_bean + fa_increase_percent_all_plants - fa_reduce_percent_bean)/100.0), 0, 5000), 0, 999999)
	
	# pumpkin 
	gt_total_pumpkin = clamp((GT_BASE_PUMPKIN + gt_increase_pumpkin - gt_reduce_pumpkin) * \
	clamp((1 + (gt_increase_percent_pumpkin - gt_reduce_percent_pumpkin)/100.0), 0, 5000), 0, 999999)
	fa_total_pumpkin = clamp((FA_BASE_PUMPKIN + fa_increase_pumpkin - fa_reduce_pumpkin) * \
	clamp((1 + (fa_increase_percent_pumpkin + fa_increase_percent_all_plants - fa_reduce_percent_pumpkin)/100.0), 0, 5000), 0, 999999)
	
	# tomato
	gt_total_tomato = clamp((GT_BASE_TOMATO + gt_increase_tomato - gt_reduce_tomato) * \
	clamp((1 + (gt_increase_percent_tomato - gt_reduce_percent_tomato)/100.0), 0, 5000), 0, 999999)
	bgt_total_tomato = clamp((BGT_BASE_TOMATO + bgt_increase_tomato - bgt_reduce_tomato) * \
	clamp((1 + (bgt_increase_percent_tomato - bgt_reduce_percent_tomato)/100.0), 0, 5000), 0, 999999)
	fa_total_tomato = clamp((FA_BASE_TOMATO + fa_increase_tomato - fa_reduce_tomato) * \
	clamp((1 + (fa_increase_percent_tomato + fa_increase_percent_all_plants - fa_reduce_percent_tomato)/100.0), 0, 5000), 0, 999999)
	
	# rice
	da_total_rice = clamp(DA_BASE_RICE + da_increase_rice + da_add_all, 0, 999999)
	
	# wheat
	da_total_wheat = clamp(DA_BASE_WHEAT + da_increase_wheat + da_add_all, 0, 999999)

	# cabbage
	da_total_cabbage = clamp(DA_BASE_CABBAGE + da_increase_cabbage + da_add_all, 0, 999999)

	# grape
	da_total_grape = clamp(DA_BASE_GRAPE + da_increase_grape + da_add_all, 0, 999999)

	# onion
	da_total_onion = clamp(DA_BASE_ONION + da_increase_onion + da_add_all, 0, 999999)

	# corn
	da_total_corn = clamp(DA_BASE_CORN + da_increase_corn + da_add_all, 0, 999999)

	# bean
	da_total_bean = clamp(DA_BASE_BEAN + da_increase_bean + da_add_all, 0, 999999)

	# pumpkin
	da_total_pumpkin = clamp(DA_BASE_PUMPKIN + da_increase_pumpkin + da_add_all, 0, 999999)

	# tomato
	da_total_tomato = clamp(DA_BASE_TOMATO + da_increase_tomato + da_add_all, 0, 999999)
	
	drop_item_distance_total = \
	clamp(DROP_ITEM_DISTANCE_BASE + drop_item_distance_increase - drop_item_distance_decrease, 100, 1000)
	
	emit_signal("all_stat_refresh")
	
	
	
func da_chance_cul(plants: String) -> bool:
	var chance = 0
	var rand = randi_range(1, 100)
	match plants:
		"rice":
			chance = da_chance_rice
		"wheat":
			chance = da_chance_wheat
		"cabbage":
			chance = da_chance_cabbage
		"grape":
			chance = da_chance_grape
		"onion":
			chance = da_chance_onion
		"corn":
			chance = da_chance_corn
		"bean":
			chance = da_chance_bean
		"pumpkin":
			chance = da_chance_pumpkin
		"tomato":
			chance = da_chance_tomato


	if chance >= rand:
		return true
	else:
		return false

func da_amount_cul(plants: String) -> int:
	var da_additional = 0

	match plants:
		"rice":
			da_additional = da_total_rice
		"wheat":
			da_additional = da_total_wheat
		"cabbage":
			da_additional = da_total_cabbage
		"grape":
			da_additional = da_total_grape
		"onion":
			da_additional = da_total_onion
		"corn":
			da_additional = da_total_corn
		"bean":
			da_additional = da_total_bean
		"pumpkin":
			da_additional = da_total_pumpkin
		"tomato":
			da_additional = da_total_tomato

	if da_chance_cul(plants):
		da_additional += 1
	return da_additional

# var total_gold = 0
var bonus_gold = 0
var bonus_gold_percent = 0

signal gold_changed
func add_gold(amount):
	current_gold += int(round(amount * clamp(1+ (bonus_gold_percent * 0.01), 1, 100000000000) + bonus_gold))
	total_gold += int(round(amount * clamp(1+ (bonus_gold_percent * 0.01), 1, 100000000000) + bonus_gold))
	emit_signal("gold_changed")

func tween_ddiyong(node):
	var tween = create_tween()
	tween.tween_property(node, "scale", Vector2(1.2, 0.8), 0.07)
	tween.tween_property(node, "scale", Vector2(1, 1), 0.07)



##############################
#     수확물 관련 함수         #
##############################

# 1. 스폰 애니메이션
func create_spawn_tween(node: Node, duration_min: float, duration_max: float) -> Tween:
	var tween = create_tween()
	var scale_tween = create_tween()
	var angle = randf() * TAU
	var distance = randf_range(100, drop_item_distance_total)
	var target = node.position + Vector2(cos(angle), sin(angle)) * distance
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(node, "position", target, randf_range(duration_min, duration_max))
	
	scale_tween.tween_property(node, "scale", Vector2(2, 2), 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CIRC)
	scale_tween.parallel().tween_property(node, "scale", Vector2(1, 1), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CIRC)
	return tween

# 2. 수확(마커로 빨려들어가기) 애니메이션
func create_collect_tween(node: Node) -> Tween:
	var first_scale = node.scale * 1.2
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(node, "scale", first_scale, 0.05)
	tween.tween_property(node, "scale", Vector2(0, 0), 0.2)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_EXPO)
	return tween

# 3. CanvasLayer로 reparent (화면 좌표계 유지)
func reparent_to_canvas_layer(node: Node, marker: Node) -> void:
	var current_screen_pos = node.get_global_transform_with_canvas().origin
	var canvas = marker.get_parent()
	node.get_parent().remove_child(node)
	canvas.add_child(node)
	node.global_position = current_screen_pos



var occupied_fields: Dictionary = {}  # Vector2i -> 식물 노드 위치

func set_occupied(grid_pos: Vector2i, plant_node: Node) -> void:
	occupied_fields[grid_pos] = plant_node

func is_occupied(grid_pos: Vector2i) -> bool:
	return occupied_fields.has(grid_pos)

func clear_occupied(grid_pos: Vector2i) -> void:
	if occupied_fields.has(grid_pos):
		occupied_fields.erase(grid_pos)
		print("칸 비움: ", grid_pos)


signal time_stop_signal
signal time_start_signal

func time_stop():
	time_stop_signal.emit()
	

func time_start():
	time_start_signal.emit()
	
	
signal to_next_morning
func next_morning():
	time_start()
	to_next_morning.emit()
	current_round += 1
	

### 라운드 클리어 작물 양 기준
var current_round = 1
var clear_requirments: Dictionary = {
	1: 50,
	2: 100,
	3: 300,
	4: 800,
	5: 2000,
	6: 6000,
	7: 30000,
	8: 100000,
	9: 500000,
	10: 2000000,
	11: 5000000,
	12: 20000000,
	13: 50000000,
	14: 99999999,
	15: 100000000
}

var round_clear = false

func round_clear_check():
	if current_gold < clear_requirments[current_round]:
		print("라운드 클리어 실패")
		round_clear = false
	else:
		print("라운드 클리어")
		round_clear = true


signal ui_hide_signal
func ui_hide():
	ui_hide_signal.emit()

signal ui_show_signal
func ui_show():
	ui_show_signal.emit()


### ### ### ### ### ### ### 
# 포맷
##############################

func format_with_commas(n: int) -> String:
	var s := str(n)
	var out := ""
	while s.length() > 3:
		out = "," + s.substr(s.length() - 3, 3) + out
		s = s.substr(0, s.length() - 3)
	return s + out

func format_num_custom(value: int) -> String:
	if value >= 1_000_000_000_000: # 1조 이상이면 M 단위
		return format_with_commas(value / 1_000_000) + "M"
	elif value >= 100_000_000: # 1억 이상이면 K 단위
		return format_with_commas(value / 1_000) + "K"
	else:
		return format_with_commas(value)


##############################################
############## 아이템 ####################
###################################

func apply_item(item_id: int) -> void:
	match item_id / 1000:
		1:
			_apply_common_item(item_id)
		2:
			_apply_rare_item(item_id)
		3:
			_apply_epic_item(item_id)
		4:
			_apply_unique_item(item_id)
		_:
			push_error("알 수 없는 아이템 ID입니다: %d" % item_id)
	stat_refresh()


func remove_item(item_id: int) -> void:
	match item_id / 1000:
		1:
			_remove_common_item(item_id)
		2:
			_remove_rare_item(item_id)
		3:
			_remove_epic_item(item_id)
		4:
			_remove_unique_item(item_id)
		_:
			push_error("알 수 없는 아이템 ID입니다: %d" % item_id)
	stat_refresh()
func _apply_common_item(item_id: int) -> void:
	match item_id:
		1001: # 조개껍질 — 모든 작물 가격 + 10 G
			fa_increase_rice += 10
			fa_increase_wheat += 10
			fa_increase_cabbage += 10
			fa_increase_grape += 10
			fa_increase_onion += 10
			fa_increase_corn += 10
			fa_increase_bean += 10
			fa_increase_pumpkin += 10
			fa_increase_tomato += 10
		1002: # 개똥 — 전체 작물 추가 수확 확률 + 10%, 작물 드랍 거리 + 30
			da_chance_rice += 10
			da_chance_wheat += 10
			da_chance_cabbage += 10
			da_chance_grape += 10
			da_chance_onion += 10
			da_chance_corn += 10
			da_chance_bean += 10
			da_chance_pumpkin += 10
			da_chance_tomato += 10
			drop_item_distance_increase += 30
		1003: # 똥 묻은 장화 — 이동속도 + 50, 아이템 보상 희귀도 Lv + 1
			additional_move_speed += 50
			reward_level += 1
		1004: # 삐걱이는 호미 — 쌀 가격 + 10 G, 쌀 씨앗 + 1개
			fa_increase_rice += 10
			sa_add_rice += 1
			sa_total_rice += 1
		1005: # 낡은 삽 — 양배추 가격 + 7 G, 양배추 씨앗 + 1개
			fa_increase_cabbage += 7
			sa_add_cabbage += 1
			sa_total_cabbage += 1
		1006: # 시큼한 포도즙 — 포도 성장시간 가속 + 10%, 포도 씨앗 + 1개
			bgt_reduce_percent_grape += 10
			sa_add_grape += 1
			sa_total_grape += 1
		1007: # 씁쓸한 양파즙 — 양파 성장시간 가속 + 20%, 양파 씨앗 + 1개
			gt_reduce_percent_onion += 20
			sa_add_onion += 1
			sa_total_onion += 1
		1008: # 옥수수 수염차 — 옥수수 가격 + 5 G, 옥수수 씨앗 + 1개
			fa_increase_corn += 5
			sa_add_corn += 1
			sa_total_corn += 1
		1009: # 콩깍지 — 콩 성장시간 가속 + 3초, 콩 씨앗 + 2개
			bgt_reduce_bean += 3
			sa_add_bean += 2
			sa_total_bean += 2
		1010: # 으스스한 호박 — 호박 가격 + 15 G, 호박 씨앗 + 1개
			fa_increase_pumpkin += 15
			sa_add_pumpkin += 1
			sa_total_pumpkin += 1
		1011: # 토마토 맛 토 — 토마토 성장시간 가속 + 10%, 토마토 씨앗 + 1개
			bgt_reduce_percent_tomato += 10
			sa_add_tomato += 1
			sa_total_tomato += 1
		1012: # 밀가루 — 밀 가격 + 10 G, 밀 씨앗 + 1개
			fa_increase_wheat += 10
			sa_add_wheat += 1
			sa_total_wheat += 1
		1013: # 성장 가속제 — 전체 작물 수확시간 가속 + 20%
			gt_reduce_percent_rice += 20
			gt_reduce_percent_wheat += 20
			gt_reduce_percent_cabbage += 20
			gt_reduce_percent_grape += 20
			gt_reduce_percent_onion += 20
			gt_reduce_percent_corn += 20
			gt_reduce_percent_bean += 20
			gt_reduce_percent_pumpkin += 20
			gt_reduce_percent_tomato += 20
		1014: # 식물 영양제 — 전체 작물 가격 + 50%
			fa_increase_percent_all_plants += 50
		1015: # 옥수수수수수 — 옥수수 가격 + 100%, 옥수수 성장시간 증가 + 400%
			fa_increase_percent_corn += 100
			bgt_increase_percent_corn += 400
		1016: # 보리보리 쌀 — 쌀 추가 수확 + 1개
			da_increase_rice += 1
		1017: # 밀가루 봉투 — 밀 수확시간 가속 + 20%
			gt_reduce_percent_wheat += 20
		1018: # 김치찌개 — 양배추 수확시간 가속 + 20%
			gt_reduce_percent_cabbage += 20
		_:
			push_error("등록되지 않은 Common 아이템입니다: %d" % item_id)
func _remove_common_item(item_id: int) -> void:
	match item_id:
		1001: # 조개껍질
			fa_increase_rice -= 10
			fa_increase_wheat -= 10
			fa_increase_cabbage -= 10
			fa_increase_grape -= 10
			fa_increase_onion -= 10
			fa_increase_corn -= 10
			fa_increase_bean -= 10
			fa_increase_pumpkin -= 10
			fa_increase_tomato -= 10
		1002: # 개똥
			da_chance_rice -= 10
			da_chance_wheat -= 10
			da_chance_cabbage -= 10
			da_chance_grape -= 10
			da_chance_onion -= 10
			da_chance_corn -= 10
			da_chance_bean -= 10
			da_chance_pumpkin -= 10
			da_chance_tomato -= 10
			drop_item_distance_increase -= 30
		1003: # 똥 묻은 장화
			additional_move_speed -= 50
			reward_level -= 1
		1004: # 삐걱이는 호미
			fa_increase_rice -= 10
			sa_add_rice -= 1
			sa_total_rice = maxi(sa_total_rice - 1, 0)
		1005: # 낡은 삽
			fa_increase_cabbage -= 7
			sa_add_cabbage -= 1
			sa_total_cabbage = maxi(sa_total_cabbage - 1, 0)
		1006: # 시큼한 포도즙
			bgt_reduce_percent_grape -= 10
			sa_add_grape -= 1
			sa_total_grape = maxi(sa_total_grape - 1, 0)
		1007: # 씁쓸한 양파즙
			gt_reduce_percent_onion -= 20
			sa_add_onion -= 1
			sa_total_onion = maxi(sa_total_onion - 1, 0)
		1008: # 옥수수 수염차
			fa_increase_corn -= 5
			sa_add_corn -= 1
			sa_total_corn = maxi(sa_total_corn - 1, 0)
		1009: # 콩깍지
			bgt_reduce_bean -= 3
			sa_add_bean -= 2
			sa_total_bean = maxi(sa_total_bean - 2, 0)
		1010: # 으스스한 호박
			fa_increase_pumpkin -= 15
			sa_add_pumpkin -= 1
			sa_total_pumpkin = maxi(sa_total_pumpkin - 1, 0)
		1011: # 토마토 맛 토
			bgt_reduce_percent_tomato -= 10
			sa_add_tomato -= 1
			sa_total_tomato = maxi(sa_total_tomato - 1, 0)
		1012: # 밀가루
			fa_increase_wheat -= 10
			sa_add_wheat -= 1
			sa_total_wheat = maxi(sa_total_wheat - 1, 0)
		1013: # 성장 가속제
			gt_reduce_percent_rice -= 20
			gt_reduce_percent_wheat -= 20
			gt_reduce_percent_cabbage -= 20
			gt_reduce_percent_grape -= 20
			gt_reduce_percent_onion -= 20
			gt_reduce_percent_corn -= 20
			gt_reduce_percent_bean -= 20
			gt_reduce_percent_pumpkin -= 20
			gt_reduce_percent_tomato -= 20
		1014: # 식물 영양제
			fa_increase_percent_all_plants -= 50
		1015: # 옥수수수수수
			fa_increase_percent_corn -= 100
			bgt_increase_percent_corn -= 400
		1016: # 보리보리 쌀
			da_increase_rice -= 1
		1017: # 밀가루 봉투
			gt_reduce_percent_wheat -= 20
		1018: # 김치찌개
			gt_reduce_percent_cabbage -= 20
		_:
			push_error("등록되지 않은 Common 아이템입니다: %d" % item_id)
			
func _apply_rare_item(item_id: int) -> void:
	match item_id:
		2001: # 날개달린 신발 — 이동속도 + 100, 아이템 보상 희귀도 Lv + 1
			additional_move_speed += 100
			reward_level += 1
		2002: # 갈대 피리 — 쌀 수확시간 가속 + 10%, 밀 수확시간 가속 + 10%
			gt_reduce_percent_rice += 10
			gt_reduce_percent_wheat += 10
		2003: # 곰팡이 핀 빵 — 작물 드랍 거리 - 50, 아이템 보상 희귀도 Lv + 1
			drop_item_distance_decrease += 50
			reward_level += 1
		2004: # 콩밥 — 쌀 가격 + 30%, 쌀 수확시간 가속 + 10초, 콩 가격 + 10%, 콩 성장시간 가속 + 5초
			fa_increase_percent_rice += 30
			gt_reduce_rice += 10
			fa_increase_percent_bean += 10
			gt_reduce_bean += 5
		2005: # 쌀벌레 한마리 — 쌀 수확시간 가속 + 70%, 쌀 가격 - 25%, 쌀 씨앗 + 2개
			gt_reduce_percent_rice += 70
			fa_reduce_percent_rice += 25
			sa_add_rice += 2
			sa_total_rice += 2
		2006: # 밀짚모자 — 밀 가격 + 100%
			fa_increase_percent_wheat += 100
		2007: # 고소한 콩가루 — 콩 가격 + 200%
			fa_increase_percent_bean += 200
		2008: # 강한 중력 — 작물 드랍 거리 - 200, 이동속도 - 200
			drop_item_distance_decrease += 200
			decrease_move_speed += 200
		2009: # 쌀가마니 — 쌀 씨앗 + 2개, 쌀 가격 + 200%
			sa_add_rice += 2
			sa_total_rice += 2
			fa_increase_percent_rice += 200
		2010: # 재활용 양배추 — 양배추 씨앗 + 3개, 양배추 수확시간 가속 + 50%
			sa_add_cabbage += 3
			sa_total_cabbage += 3
			gt_reduce_percent_cabbage += 50
		2011: # 까도까도 양파 — 양파 씨앗 + 6개, 양파 외 작물 가격 - 30%
			sa_add_onion += 6
			sa_total_onion += 6
			fa_reduce_percent_rice += 30
			fa_reduce_percent_wheat += 30
			fa_reduce_percent_cabbage += 30
			fa_reduce_percent_grape += 30
			fa_reduce_percent_corn += 30
			fa_reduce_percent_bean += 30
			fa_reduce_percent_pumpkin += 30
			fa_reduce_percent_tomato += 30
		2012: # 나는 포도 도둑 — 포도 씨앗 + 10개, 포도 수확시간 증가 + 100%
			sa_add_grape += 10
			sa_total_grape += 10
			gt_increase_percent_grape += 100
		2013: # 옥수수를 심어 — 옥수수 씨앗 + 4개, 옥수수 성장시간 가속 + 50%
			sa_add_corn += 4
			sa_total_corn += 4
			bgt_reduce_percent_corn += 50
		2014: # 콩알탄 — 콩 추가 수확 + 2개, 작물 드랍 거리 + 500
			da_increase_bean += 2
			drop_item_distance_increase += 500
		2015: # 호박은 맛없어 — 호박 씨앗 + 3개, 호박 추가 수확 + 1개
			sa_add_pumpkin += 3
			sa_total_pumpkin += 3
			da_increase_pumpkin += 1
		2016: # 에너지드링크 — 전체 작물 가격 + 50%
			fa_increase_percent_all_plants += 50
		2017: # 슈퍼드링크 — 전체 작물 성장시간 가속 + 20%, 이동속도 + 100
			gt_reduce_percent_rice += 20
			gt_reduce_percent_wheat += 20
			gt_reduce_percent_cabbage += 20
			gt_reduce_percent_onion += 20
			gt_reduce_percent_pumpkin += 20
			bgt_reduce_percent_grape += 20
			bgt_reduce_percent_corn += 20
			bgt_reduce_percent_bean += 20
			bgt_reduce_percent_tomato += 20
			additional_move_speed += 100
		2018: # 행운의 삽 — 전체 작물 추가 수확 확률 + 50%
			da_chance_rice += 50
			da_chance_wheat += 50
			da_chance_cabbage += 50
			da_chance_grape += 50
			da_chance_onion += 50
			da_chance_corn += 50
			da_chance_bean += 50
			da_chance_pumpkin += 50
			da_chance_tomato += 50
		_:
			push_error("등록되지 않은 Rare 아이템입니다: %d" % item_id)
			
func _remove_rare_item(item_id: int) -> void:
	match item_id:
		2001: # 날개달린 신발
			additional_move_speed -= 100
			reward_level -= 1
		2002: # 갈대 피리
			gt_reduce_percent_rice -= 10
			gt_reduce_percent_wheat -= 10
		2003: # 곰팡이 핀 빵
			drop_item_distance_decrease -= 50
			reward_level -= 1
		2004: # 콩밥
			fa_increase_percent_rice -= 30
			gt_reduce_rice -= 10
			fa_increase_percent_bean -= 10
			gt_reduce_bean -= 5
		2005: # 쌀벌레 한마리
			gt_reduce_percent_rice -= 70
			fa_reduce_percent_rice -= 25
			sa_add_rice -= 2
			sa_total_rice = maxi(sa_total_rice - 2, 0)
		2006: # 밀짚모자
			fa_increase_percent_wheat -= 100
		2007: # 고소한 콩가루
			fa_increase_percent_bean -= 200
		2008: # 강한 중력
			drop_item_distance_decrease -= 200
			decrease_move_speed -= 200
		2009: # 쌀가마니
			sa_add_rice -= 2
			sa_total_rice = maxi(sa_total_rice - 2, 0)
			fa_increase_percent_rice -= 200
		2010: # 재활용 양배추
			sa_add_cabbage -= 3
			sa_total_cabbage = maxi(sa_total_cabbage - 3, 0)
			gt_reduce_percent_cabbage -= 50
		2011: # 까도까도 양파
			sa_add_onion -= 6
			sa_total_onion = maxi(sa_total_onion - 6, 0)
			fa_reduce_percent_rice -= 30
			fa_reduce_percent_wheat -= 30
			fa_reduce_percent_cabbage -= 30
			fa_reduce_percent_grape -= 30
			fa_reduce_percent_corn -= 30
			fa_reduce_percent_bean -= 30
			fa_reduce_percent_pumpkin -= 30
			fa_reduce_percent_tomato -= 30
		2012: # 나는 포도 도둑
			sa_add_grape -= 10
			sa_total_grape = maxi(sa_total_grape - 10, 0)
			gt_increase_percent_grape -= 100
		2013: # 옥수수를 심어
			sa_add_corn -= 4
			sa_total_corn = maxi(sa_total_corn - 4, 0)
			bgt_reduce_percent_corn -= 50
		2014: # 콩알탄
			da_increase_bean -= 2
			drop_item_distance_increase -= 500
		2015: # 호박은 맛없어
			sa_add_pumpkin -= 3
			sa_total_pumpkin = maxi(sa_total_pumpkin - 3, 0)
			da_increase_pumpkin -= 1
		2016: # 에너지드링크
			fa_increase_percent_all_plants -= 50
		2017: # 슈퍼드링크
			gt_reduce_percent_rice -= 20
			gt_reduce_percent_wheat -= 20
			gt_reduce_percent_cabbage -= 20
			gt_reduce_percent_onion -= 20
			gt_reduce_percent_pumpkin -= 20
			bgt_reduce_percent_grape -= 20
			bgt_reduce_percent_corn -= 20
			bgt_reduce_percent_bean -= 20
			bgt_reduce_percent_tomato -= 20
			additional_move_speed -= 100
		2018: # 행운의 삽
			da_chance_rice -= 50
			da_chance_wheat -= 50
			da_chance_cabbage -= 50
			da_chance_grape -= 50
			da_chance_onion -= 50
			da_chance_corn -= 50
			da_chance_bean -= 50
			da_chance_pumpkin -= 50
			da_chance_tomato -= 50
		_:
			push_error("등록되지 않은 Rare 아이템입니다: %d" % item_id)
			
func _apply_epic_item(item_id: int) -> void:
	match item_id:
		3001: # 마법이 깃든 잎 — 전체 작물 추가 수확 + 1개, 아이템 보상 희귀도 Lv + 1
			da_add_all += 1
			reward_level += 1
		3002: # 떡케이크 — 쌀 씨앗 + 3개, 쌀 가격 + 300%
			sa_add_rice += 3
			sa_total_rice += 3
			fa_increase_percent_rice += 300
		3003: # 지푸라기 인형 — 밀 추가 수확 + 3개
			da_increase_wheat += 3
		3004: # 김치 — 양배추 수확시간 가속 + 60%, 양배추 가격 + 300%
			gt_reduce_percent_cabbage += 60
			fa_increase_percent_cabbage += 300
		3005: # 포도알 부자 — 포도 추가 수확 + 7개, 포도 가격 - 30%
			da_increase_grape += 7
			fa_reduce_percent_grape += 30
		3006: # 갑옷입은 양파 — 양파 가격 + 1000%, 양파 성장시간 증가 + 300%
			fa_increase_percent_onion += 1000
			gt_increase_percent_onion += 300
		3007: # 흰수염 옥수수 — 옥수수 추가 수확 + 2개, 옥수수 가격 + 100 G
			da_increase_corn += 2
			fa_increase_corn += 100
		3008: # 너무많은 콩 — 콩 추가 수확 + 3개, 콩 성장시간 가속 + 5초
			da_increase_bean += 3
			bgt_reduce_bean += 5
		3009: # 펌킨킹 — 호박 씨앗 + 2개, 호박 가격 + 1000%
			sa_add_pumpkin += 2
			sa_total_pumpkin += 2
			fa_increase_percent_pumpkin += 1000
		3010: # 토 맛 토마토 — 토마토 수확시간 가속 + 60%, 토마토 추가 수확 + 2개
			gt_reduce_percent_tomato += 60
			da_increase_tomato += 2
		_:
			push_error("등록되지 않은 Epic 아이템입니다: %d" % item_id)
			
func _remove_epic_item(item_id: int) -> void:
	match item_id:
		3001: # 마법이 깃든 잎
			da_add_all -= 1
			reward_level -= 1
		3002: # 떡케이크
			sa_add_rice -= 3
			sa_total_rice = maxi(sa_total_rice - 3, 0)
			fa_increase_percent_rice -= 300
		3003: # 지푸라기 인형
			da_increase_wheat -= 3
		3004: # 김치
			gt_reduce_percent_cabbage -= 60
			fa_increase_percent_cabbage -= 300
		3005: # 포도알 부자
			da_increase_grape -= 7
			fa_reduce_percent_grape -= 30
		3006: # 갑옷입은 양파
			fa_increase_percent_onion -= 1000
			gt_increase_percent_onion -= 300
		3007: # 흰수염 옥수수
			da_increase_corn -= 2
			fa_increase_corn -= 100
		3008: # 너무많은 콩
			da_increase_bean -= 3
			bgt_reduce_bean -= 5
		3009: # 펌킨킹
			sa_add_pumpkin -= 2
			sa_total_pumpkin = maxi(sa_total_pumpkin - 2, 0)
			fa_increase_percent_pumpkin -= 1000
		3010: # 토 맛 토마토
			gt_reduce_percent_tomato -= 60
			da_increase_tomato -= 2
		_:
			push_error("등록되지 않은 Epic 아이템입니다: %d" % item_id)
			
func _apply_unique_item(item_id: int) -> void:
	match item_id:
		4001: # 이기적인 양파 — 양파 가격 + 1000%, 다른 작물 가격 - 30%
			fa_increase_percent_onion += 1000
			fa_reduce_percent_rice += 30
			fa_reduce_percent_wheat += 30
			fa_reduce_percent_cabbage += 30
			fa_reduce_percent_grape += 30
			fa_reduce_percent_corn += 30
			fa_reduce_percent_bean += 30
			fa_reduce_percent_pumpkin += 30
			fa_reduce_percent_tomato += 30
		_:
			push_error("등록되지 않은 Unique 아이템입니다: %d" % item_id)


func _remove_unique_item(item_id: int) -> void:
	match item_id:
		4001: # 이기적인 양파
			fa_increase_percent_onion -= 1000
			fa_reduce_percent_rice -= 30
			fa_reduce_percent_wheat -= 30
			fa_reduce_percent_cabbage -= 30
			fa_reduce_percent_grape -= 30
			fa_reduce_percent_corn -= 30
			fa_reduce_percent_bean -= 30
			fa_reduce_percent_pumpkin -= 30
			fa_reduce_percent_tomato -= 30
		_:
			push_error("등록되지 않은 Unique 아이템입니다: %d" % item_id)
	
	
	
	



var item_database: Dictionary = {} # item_id -> ItemResource

func _load_all_items() -> void:
	item_database.clear()

	for res in ItemRegistry.ALL:
		if res is ItemResource:
			if item_database.has(res.item_id):
				push_error("아이템 ID가 중복되었습니다: %d" % res.item_id)
			item_database[res.item_id] = res
		else:
			push_error("ItemResource가 아닌 항목이 명단에 있습니다.")

	print("아이템 로드 완료: %d개" % item_database.size())

func get_item_by_id(item_id: int) -> ItemResource:
	if not item_database.has(item_id):
		push_error("존재하지 않는 아이템 ID입니다: %d" % item_id)
		return null

	return item_database[item_id]
func money_get_label(money):
	var money_label = preload("res://scene/money_get_label.tscn").instantiate()
	add_child(money_label)
var item_inventory: Array = []

func format_time(total_seconds: int) -> String:
	var hours = total_seconds / 3600
	var minutes = (total_seconds % 3600) / 60
	var seconds = total_seconds % 60
	
	if hours > 0:
		return "%d시간 %02d분 %02d초" % [hours, minutes, seconds]
	elif minutes > 0:
		return "%02d분 %02d초" % [minutes, seconds]
	else:
		return "%02d초" % [seconds]


func reset_for_new_game() -> void:
	# 게임 결과 / 진행
	play_time = 0
	total_plants = 0
	total_gold = 0
	current_gold = 0
	current_ticket = 0
	reward_level = 1
	current_round = 1
	round_clear = false

	# 이동 속도
	additional_move_speed = 0
	decrease_move_speed = 0
	total_move_speed = 0

	# 골드 보너스
	bonus_gold = 0
	bonus_gold_percent = 0

	# 드랍 범위
	drop_item_distance_increase = 0
	drop_item_distance_decrease = 0
	drop_item_distance_total = 0

	# 전체 작물 공용
	gt_reduce_percent_all_plants = 0
	gt_reduce_all_plants = 0
	gt_increase_percent_all_plants = 0
	gt_increase_all_plants = 0
	fa_increase_percent_all_plants = 0
	da_add_all = 0
	item_reward_chance = 1

	# 인벤토리 / 필드
	item_inventory.clear()
	occupied_fields.clear()

	# 작물별 스탯 초기화
	_reset_all_crop_stats()




func _reset_all_crop_stats() -> void:
	var crops = ["rice", "wheat", "cabbage", "grape", "onion", "corn", "bean", "pumpkin", "tomato"]
	for c in crops:
		set("da_chance_" + c, 0)
		set("da_increase_" + c, 0)
		set("gt_reduce_percent_" + c, 0)
		set("gt_reduce_" + c, 0)
		set("gt_increase_percent_" + c, 0)
		set("gt_increase_" + c, 0)
		set("fa_increase_percent_" + c, 0)
		set("fa_increase_" + c, 0)
		set("fa_reduce_percent_" + c, 0)
		set("fa_reduce_" + c, 0)
		set("sa_add_" + c, 0)
		set("sa_total_" + c, 3)

	# bgt 계열이 있는 작물만 별도 처리
	var bgt_crops = ["grape", "corn", "bean", "tomato"]
	for c in bgt_crops:
		set("bgt_reduce_percent_" + c, 0)
		set("bgt_reduce_" + c, 0)
		set("bgt_increase_percent_" + c, 0)
		set("bgt_increase_" + c, 0)
	stat_refresh()

signal cry_signal
func cry():
	cry_signal.emit()
