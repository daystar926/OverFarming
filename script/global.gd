extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
var current_gold = 6000
var current_ticket = 0

### bgt = base grow time 기본 성장 시간
### gt = grow time 수확 시간
### fa = farming amount 가격
### da = drop amount 드랍되는 작물 갯수
### sa = seed amount 모종 갯수
const GT_BASE_RICE = 90
const GT_BASE_WHEAT = 60
const GT_BASE_CABBAGE = 30
const GT_BASE_STRAWBERRY = 30
const BGT_BASE_STRAWBERRY = 30
const GT_BASE_GARLIC = 50
const GT_BASE_CORN = 50
const BGT_BASE_CORN = 50
const GT_BASE_BEAN = 30
const BGT_BASE_BEAN = 20
const GT_BASE_SWEET_POTATO = 30
const MGT_BASE_SWEET_POTATO = 90 # 기본 맥시멈 성장 수치 / 이렇게 설정해야하나 ? 다르게 설정해야하나 몰겠네
const GT_BASE_TOMATO = 40
const BGT_BASE_TOMATO = 40

const FA_BASE_RICE = 10
const FA_BASE_WHEAT = 7
const FA_BASE_CABBAGE = 3
const FA_BASE_STRAWBERRY = 3
const FA_BASE_GARLIC = 7
const FA_BASE_CORN = 5
const FA_BASE_BEAN = 2
const FA_BASE_TOMATO = 4

const DA_BASE_RICE = 1
const DA_BASE_WHEAT = 1
const DA_BASE_CABBAGE = 1
const DA_BASE_STRAWBERRY = 1
const DA_BASE_GARLIC = 1
const DA_BASE_CORN = 1
const DA_BASE_BEAN = 1
const DA_BASE_SWEET_POTATO = 1
const DA_BASE_TOMATO = 1

var additional_move_speed = 0
var base_move_speed = 400
var total_move_speed = 0
var gt_reduce_percent_all_plants = 0
var gt_reduce_all_plants = 0
var gt_increase_percent_all_plants = 0
var gt_increase_all_plants = 0

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

# strawberry
var da_chance_strawberry = 0
var da_increase_strawberry = 0

# garlic
var da_chance_garlic = 0
var da_increase_garlic = 0

# corn
var da_chance_corn = 0
var da_increase_corn = 0

# bean
var da_chance_bean = 0
var da_increase_bean = 0

# sweet_potato
var da_chance_sweet_potato = 0
var da_increase_sweet_potato = 0

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

# strawberry
var gt_reduce_percent_strawberry = 0
var gt_reduce_strawberry = 0
var gt_increase_percent_strawberry = 0
var gt_increase_strawberry = 0
var fa_increase_percent_strawberry = 0
var fa_increase_strawberry = 0
var fa_reduce_percent_strawberry = 0
var fa_reduce_strawberry = 0
var sa_add_strawberry = 0
# strawberry bgt
var bgt_reduce_percent_strawberry = 0
var bgt_reduce_strawberry = 0
var bgt_increase_percent_strawberry = 0
var bgt_increase_strawberry = 0
#var sa_base_strawberry = 0

# garlic
var gt_reduce_percent_garlic = 0
var gt_reduce_garlic = 0
var gt_increase_percent_garlic = 0
var gt_increase_garlic = 0
var fa_increase_percent_garlic = 0
var fa_increase_garlic = 0
var fa_reduce_percent_garlic = 0
var fa_reduce_garlic = 0
var sa_add_garlic = 0
#var sa_base_garlic = 0

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

# sweet_potato
var gt_reduce_percent_sweet_potato = 0
var gt_reduce_sweet_potato = 0
var gt_increase_percent_sweet_potato = 0
var gt_increase_sweet_potato = 0
var fa_increase_percent_sweet_potato = 0
var fa_increase_sweet_potato = 0
var fa_reduce_percent_sweet_potato = 0
var fa_reduce_sweet_potato = 0
var sa_add_sweet_potato = 0
#var sa_base_sweet_potato = 0

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

# strawberry total
var gt_total_strawberry = 0
var bgt_total_strawberry = 0
var fa_total_strawberry = 0
var sa_total_strawberry = 3

# garlic total
var gt_total_garlic = 0
var fa_total_garlic = 0
var sa_total_garlic = 0

# corn total
var gt_total_corn = 0
var bgt_total_corn = 0
var fa_total_corn = 0
var sa_total_corn = 0

# bean total
var gt_total_bean = 0
var bgt_total_bean = 0
var fa_total_bean = 0
var sa_total_bean = 0


# sweet_potato total
var gt_total_sweet_potato = 0
var fa_total_sweet_potato = 0
var sa_total_sweet_potato = 0

# tomato total
var gt_total_tomato = 0
var bgt_total_tomato = 0
var fa_total_tomato = 0
var sa_total_tomato = 0

# rice total
var da_total_rice = 0

# wheat total
var da_total_wheat = 0

# cabbage total
var da_total_cabbage = 0

# strawberry total
var da_total_strawberry = 0

# garlic total
var da_total_garlic = 0

# corn total
var da_total_corn = 0

# bean total
var da_total_bean = 0

# sweet_potato total
var da_total_sweet_potato = 0

# tomato total
var da_total_tomato = 0

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
			return sa_total_strawberry
		5:
			return sa_total_garlic
		6:
			return sa_total_corn
		7:
			return sa_total_bean
		8:
			return sa_total_sweet_potato
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
			sa_total_strawberry -= amount
		5:
			sa_total_garlic -= amount
		6:
			sa_total_corn -= amount
		7:
			sa_total_bean -= amount
		8:
			sa_total_sweet_potato -= amount
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
			sa_total_strawberry += amount
		5:
			sa_total_garlic += amount
		6:
			sa_total_corn += amount
		7:
			sa_total_bean += amount
		8:
			sa_total_sweet_potato += amount
		9:
			sa_total_tomato += amount

func stat_refresh():
	total_move_speed = clamp(base_move_speed + additional_move_speed, 0, 1000) #(아이템으로 증가 가능한 벨류)
	
	# rice

	gt_total_rice = (GT_BASE_RICE + gt_increase_rice - gt_reduce_rice) * \
	clamp((1 + (gt_increase_percent_rice - gt_reduce_percent_rice)/100.0), 0, 5000)
	fa_total_rice = (FA_BASE_RICE + fa_increase_rice - fa_reduce_rice) * \
	clamp((1 + (fa_increase_percent_rice - fa_reduce_percent_rice)/100.0), 0, 5000)
	
	# wheat

	gt_total_wheat = (GT_BASE_WHEAT + gt_increase_wheat - gt_reduce_wheat) * \
	clamp((1 + (gt_increase_percent_wheat - gt_reduce_percent_wheat)/100.0), 0, 5000)
	fa_total_wheat = (FA_BASE_WHEAT + fa_increase_wheat - fa_reduce_wheat) * \
	clamp((1 + (fa_increase_percent_wheat - fa_reduce_percent_wheat)/100.0), 0, 5000)
	
	# cabbage

	gt_total_cabbage = (GT_BASE_CABBAGE + gt_increase_cabbage - gt_reduce_cabbage) * \
	clamp((1 + (gt_increase_percent_cabbage - gt_reduce_percent_cabbage)/100.0), 0, 5000)
	fa_total_cabbage = (FA_BASE_CABBAGE + fa_increase_cabbage - fa_reduce_cabbage) * \
	clamp((1 + (fa_increase_percent_cabbage - fa_reduce_percent_cabbage)/100.0), 0, 5000)
	
	# strawberry
	gt_total_strawberry = (GT_BASE_STRAWBERRY + gt_increase_strawberry - gt_reduce_strawberry) * \
	clamp((1 + (gt_increase_percent_strawberry - gt_reduce_percent_strawberry)/100.0), 0, 5000)
	bgt_total_strawberry = (BGT_BASE_STRAWBERRY + bgt_increase_strawberry - bgt_reduce_strawberry) * \
	clamp((1 + (bgt_increase_percent_strawberry - bgt_reduce_percent_strawberry)/100.0), 0, 5000)
	fa_total_strawberry = (FA_BASE_STRAWBERRY + fa_increase_strawberry - fa_reduce_strawberry) * \
	clamp((1 + (fa_increase_percent_strawberry - fa_reduce_percent_strawberry)/100.0), 0, 5000)
	
	# garlic

	gt_total_garlic = (GT_BASE_GARLIC + gt_increase_garlic - gt_reduce_garlic) * \
	clamp((1 + (gt_increase_percent_garlic - gt_reduce_percent_garlic)/100.0), 0, 5000)
	fa_total_garlic = (FA_BASE_GARLIC + fa_increase_garlic - fa_reduce_garlic) * \
	clamp((1 + (fa_increase_percent_garlic - fa_reduce_percent_garlic)/100.0), 0, 5000)
	
	# corn
	gt_total_corn = (GT_BASE_CORN + gt_increase_corn - gt_reduce_corn) * \
	clamp((1 + (gt_increase_percent_corn - gt_reduce_percent_corn)/100.0), 0, 5000)
	bgt_total_corn = (BGT_BASE_CORN + bgt_increase_corn - bgt_reduce_corn) * \
	clamp((1 + (bgt_increase_percent_corn - bgt_reduce_percent_corn)/100.0), 0, 5000)
	fa_total_corn = (FA_BASE_CORN + fa_increase_corn - fa_reduce_corn) * \
	clamp((1 + (fa_increase_percent_corn - fa_reduce_percent_corn)/100.0), 0, 5000)
	
	# bean
	gt_total_bean = (GT_BASE_BEAN + gt_increase_bean - gt_reduce_bean) * \
	clamp((1 + (gt_increase_percent_bean - gt_reduce_percent_bean)/100.0), 0, 5000)
	bgt_total_bean = (BGT_BASE_BEAN + bgt_increase_bean - bgt_reduce_bean) * \
	clamp((1 + (bgt_increase_percent_bean - bgt_reduce_percent_bean)/100.0), 0, 5000)
	fa_total_bean = (FA_BASE_BEAN + fa_increase_bean - fa_reduce_bean) * \
	clamp((1 + (fa_increase_percent_bean - fa_reduce_percent_bean)/100.0), 0, 5000)
	
	# sweet_potato (FA_BASE 없음 — 방치형이라 별도 처리 필요)

	gt_total_sweet_potato = (GT_BASE_SWEET_POTATO + gt_increase_sweet_potato - gt_reduce_sweet_potato) * \
	clamp((1 + (gt_increase_percent_sweet_potato - gt_reduce_percent_sweet_potato)/100.0), 0, 5000)
	
	# tomato
	
	gt_total_tomato = (GT_BASE_TOMATO + gt_increase_tomato - gt_reduce_tomato) * \
	clamp((1 + (gt_increase_percent_tomato - gt_reduce_percent_tomato)/100.0), 0, 5000)
	bgt_total_tomato = (BGT_BASE_TOMATO + bgt_increase_tomato - bgt_reduce_tomato) * \
	clamp((1 + (bgt_increase_percent_tomato - bgt_reduce_percent_tomato)/100.0), 0, 5000)
	fa_total_tomato = (FA_BASE_TOMATO + fa_increase_tomato - fa_reduce_tomato) * \
	clamp((1 + (fa_increase_percent_tomato - fa_reduce_percent_tomato)/100.0), 0, 5000)
	
	# rice
	da_total_rice = DA_BASE_RICE + da_increase_rice
	
	# wheat
	da_total_wheat = DA_BASE_WHEAT + da_increase_wheat

	# cabbage
	da_total_cabbage = DA_BASE_CABBAGE + da_increase_cabbage

	# strawberry
	da_total_strawberry = DA_BASE_STRAWBERRY + da_increase_strawberry

	# garlic
	da_total_garlic = DA_BASE_GARLIC + da_increase_garlic

	# corn
	da_total_corn = DA_BASE_CORN + da_increase_corn

	# bean
	da_total_bean = DA_BASE_BEAN + da_increase_bean

	# sweet_potato
	da_total_sweet_potato = DA_BASE_SWEET_POTATO + da_increase_sweet_potato

	# tomato
	da_total_tomato = DA_BASE_TOMATO + da_increase_tomato
	
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
		"strawberry":
			chance = da_chance_strawberry
		"garlic":
			chance = da_chance_garlic
		"corn":
			chance = da_chance_corn
		"bean":
			chance = da_chance_bean
		"sweet_potato":
			chance = da_chance_sweet_potato
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
		"strawberry":
			da_additional = da_total_strawberry
		"garlic":
			da_additional = da_total_garlic
		"corn":
			da_additional = da_total_corn
		"bean":
			da_additional = da_total_bean
		"sweet_potato":
			da_additional = da_total_sweet_potato
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
	var angle = randf() * TAU
	var distance = randf_range(100, drop_item_distance_total)
	var target = node.position + Vector2(cos(angle), sin(angle)) * distance
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(node, "position", target, randf_range(duration_min, duration_max))
	
	tween.parallel().tween_property(node, "scale", Vector2(1, 1), 0.52)\
		.set_ease(tween.EASE_OUT)\
		.set_trans(tween.TRANS_ELASTIC)
	return tween

# 2. 수확(마커로 빨려들어가기) 애니메이션
func create_collect_tween(node: Node) -> Tween:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(node, "scale", Vector2(1.2, 1.2), 0.05)
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
		0: # 조개껍질 모든 아이템 판매량 +10G
			bonus_gold += 10
		1: # 개똥 작물 추가 수확 확률 +10%, 낙하 범위 +30
			da_chance_rice += 10
			da_chance_wheat += 10
			da_chance_cabbage += 10
			da_chance_strawberry += 10
			da_chance_garlic += 10
			da_chance_corn += 10
			da_chance_bean += 10
			da_chance_sweet_potato += 10
			da_chance_tomato += 10
			drop_item_distance_increase += 30
		2: # 똥 묻은 장화 이동 속도 +50
			additional_move_speed += 50
		3: # 삐걱이는 호미 쌀 수확량 증가 +10
			da_increase_rice += 10
	stat_refresh()

func remove_item(item_id: int) -> void:
	match item_id:
		0:
			bonus_gold -= 10
		1:
			da_chance_rice -= 10
			da_chance_wheat -= 10
			da_chance_cabbage -= 10
			da_chance_strawberry -= 10
			da_chance_garlic -= 10
			da_chance_corn -= 10
			da_chance_bean -= 10
			da_chance_sweet_potato -= 10
			da_chance_tomato -= 10
			drop_item_distance_increase -= 30
		2:
			additional_move_speed -= 50
		3:
			da_increase_rice -= 10
	stat_refresh()
