extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_all_items()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
var current_gold = 0
var current_ticket = 0
var reward_level = 1
### bgt = base grow time 기본 성장 시간
### gt = grow time 수확 시간
### fa = farming amount 가격
### da = drop amount 드랍되는 작물 갯수
### sa = seed amount 모종 갯수
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
	match item_id:
		1001: # 조개껍질 모든 아이템 판매량 +10G
			bonus_gold += 10
		1002: # 개똥 작물 추가 수확 확률 +10%, 낙하 범위 +30
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
		1003: # 똥 묻은 장화 이동 속도 +50
			additional_move_speed += 50
		1004: # 삐걱이는 호미 쌀 수확량 증가 +10
			fa_increase_rice += 10
		1005: # 낡은 삽 양배추 값어치 + 7G
			fa_increase_cabbage += 7
		1006: # 시큼한 포도즙 포도 성장시간 가속 + 10%
			gt_reduce_percent_grape += 10
		1007: # 씁쓸한 양파즙 양파 성장시간 가속 + 20%
			gt_reduce_percent_onion += 20
		1008: # 옥수수 수염차 옥수수 값어치 + 5G
			fa_increase_corn += 5
		1009: # 콩깍지 콩 성장시간 가속 + 3초
			gt_reduce_bean += 3
		1010: # 으스스한 호박 호박 값어치 + 15G
			fa_increase_pumpkin += 15
		1011: # 토마토 맛 토 토마토 성장시간 가속 + 20%, 토마토 수확시간 가속 + 20% 
			bgt_reduce_percent_tomato += 20
			gt_reduce_percent_tomato += 20
		1012: # 밀가루 밀 값어치 + 10G
			fa_increase_wheat += 10
		1013: # 성장 가속제 전체 작물 성장시간 가속 + 20%
			gt_reduce_percent_all_plants += 20
		1014: # 식물 영양제 전체 작물 값어치 + 50%
			fa_increase_percent_all_plants += 50
		1015: # 옥수수수수수 옥수수 값어치 + 100%, 옥수수 성장시간 증가 + 400%
			fa_increase_percent_corn += 100
			gt_increase_percent_corn += 400
		1016: # 보리보리 쌀 쌀 드랍 갯수 + 1
			da_increase_rice += 1
		1017: # 밀가루 봉투 밀 성장시간 가속 + 20%
			gt_reduce_percent_wheat += 20
		1018: # 김치찌개 양배추 성장시간 가속 + 20%
			gt_reduce_percent_cabbage += 20
		2001: # 날개달린 신발 이속 + 100
			additional_move_speed += 100
		2002: # 갈대 피리 쌀 성장속도 10% 밀 성장속도 10%
			gt_reduce_percent_rice += 10
			gt_reduce_percent_wheat += 10
		2003: # 곰팡이 핀 빵 드랍 범위 50 감소
			drop_item_distance_decrease += 50
		2004: # 콩밥, 쌀 수확량 30% 쌀 성장시간 -10% 콩 수확량 10% 콩 성장시간 -10%
			fa_increase_percent_rice += 30
			gt_reduce_rice += 10
			fa_increase_percent_bean += 10
			gt_reduce_bean += 10
		3001: # 마법이 깃든 잎 # 작물 드랍 갯수 + 1
			da_add_all += 1
		4001: # 이기적인 양파 양파 수확량 +300% 다른 작물 수확량 - 30%
			fa_increase_percent_onion += 300
			fa_reduce_percent_cabbage += 30
			fa_reduce_percent_corn += 30
			fa_reduce_percent_bean += 30
			fa_reduce_percent_rice += 30
			fa_reduce_percent_grape += 30
			fa_reduce_percent_pumpkin += 30
			fa_reduce_percent_tomato += 30
			fa_reduce_percent_wheat += 30
			
	stat_refresh()

func remove_item(item_id: int) -> void:
	match item_id:
		1001: # 조개껍질 모든 아이템 판매량 +10G
			bonus_gold -= 10
		1002: # 개똥 작물 추가 수확 확률 +10%, 낙하 범위 +30
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
		1003: # 똥 묻은 장화 이동 속도 +50
			additional_move_speed -= 50
		1004: # 삐걱이는 호미 쌀 수확량 증가 +10
			fa_increase_rice -= 10
		1005: # 낡은 삽
			fa_increase_cabbage -= 7
		1006: # 시큼한 포도즙
			gt_reduce_percent_grape -= 10
		1007: # 씁쓸한 양파즙
			gt_reduce_percent_onion -= 20
		1008: # 옥수수 수염차
			fa_increase_corn -= 5
		1009: # 콩깍지
			gt_reduce_bean -= 3
		1010: # 으스스한 호박
			fa_increase_pumpkin -= 15
		1011: # 토마토 맛 토
			bgt_reduce_percent_tomato -= 20
			gt_reduce_percent_tomato -= 20
		1012: # 밀가루
			fa_increase_wheat -= 10
		1013: # 성장 가속제
			gt_reduce_percent_all_plants -= 20
		1014: # 식물 영양제
			fa_increase_percent_all_plants -= 50
		1015: # 옥수수수수수
			fa_increase_percent_corn -= 100
			gt_increase_percent_corn -= 400
		1016: # 보리보리 쌀
			da_increase_rice -= 1
		1017: # 밀가루 봉투
			gt_reduce_percent_wheat -= 20
		1018: # 김치찌개
			gt_reduce_percent_cabbage -= 20
		2001: # 날개달린 신발 이속 + 100
			additional_move_speed -= 100
		2002: # 갈대 피리 쌀 성장속도 10% 밀 성장속도 10%
			gt_reduce_rice -= 10
			gt_reduce_wheat -= 10
		2003: # 곰팡이 핀 빵 드랍 범위 50 감소
			drop_item_distance_decrease -= 50
		2004: # 콩밥, 쌀 수확량 30% 쌀 성장시간 -10% 콩 수확량 10% 콩 성장시간 -10%
			fa_increase_percent_rice -= 30
			gt_reduce_rice -= 10
			fa_increase_percent_bean -= 10
			gt_reduce_bean -= 10
		3001: # 마법이 깃든 잎 # 작물 드랍 갯수 + 1
			da_add_all -= 1
		4001: # 이기적인 양파 양파 수확량 +300% 다른 작물 수확량 - 30%
			fa_increase_percent_onion -= 300
			fa_reduce_percent_cabbage -= 30
			fa_reduce_percent_corn -= 30
			fa_reduce_percent_bean -= 30
			fa_reduce_percent_rice -= 30
			fa_reduce_percent_grape -= 30
			fa_reduce_percent_pumpkin -= 30
			fa_reduce_percent_tomato -= 30
			fa_reduce_percent_wheat -= 30
	stat_refresh()
	
	
	
	
var item_database: Dictionary = {} # item_id -> ItemResource
const ITEM_DIR: String = "res://resource/item/"



func _load_all_items() -> void:
	_scan_directory(ITEM_DIR)

func _scan_directory(path: String) -> void:
	var dir: DirAccess = DirAccess.open(path)
	if dir == null:
		push_error("폴더를 열 수 없습니다: %s" % path)
		return

	dir.list_dir_begin()
	var file_name: String = dir.get_next()

	while file_name != "":
		if file_name == "." or file_name == "..":
			file_name = dir.get_next()
			continue

		var full_path: String = path.path_join(file_name)

		if dir.current_is_dir():
			_scan_directory(full_path) # 하위 폴더 재귀 탐색
		elif file_name.ends_with(".tres"):
			var resource: Resource = load(full_path)
			if resource is ItemResource:
				item_database[resource.item_id] = resource

		file_name = dir.get_next()

	dir.list_dir_end()


func get_item_by_id(item_id: int) -> ItemResource:
	if not item_database.has(item_id):
		push_error("존재하지 않는 아이템 ID입니다: %d" % item_id)
		return null

	return item_database[item_id]

var item_inventory: Array = []

func money_get_label(money):
	var money_label = preload("res://scene/money_get_label.tscn").instantiate()
	add_child(money_label)
