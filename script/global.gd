extends Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
### bgt = base grow time 기본 성장 시간
### gt = grow time 수확 시간
### fa = farming amount 수확량
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


var additional_move_speed = 0
var base_move_speed = 400
var total_move_speed = 0
var gt_reduce_percent_all_plants = 0
var gt_reduce_all_plants = 0
var gt_increase_percent_all_plants = 0
var gt_increase_all_plants = 0

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
var sa_base_rice = 3

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
var sa_base_wheat = 0

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
var sa_base_cabbage = 0

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
var sa_base_strawberry = 0

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
var sa_base_garlic = 0

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
var sa_base_corn = 0

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
var sa_base_bean = 0

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
var sa_base_sweet_potato = 0

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
var sa_base_tomato = 0

# rice total
var gt_total_rice = 0
var fa_total_rice = 0
var sa_total_rice = 0

# wheat total
var gt_total_wheat = 0
var fa_total_wheat = 0
var sa_total_wheat = 0

# cabbage total
var gt_total_cabbage = 0
var fa_total_cabbage = 0
var sa_total_cabbage = 0

# strawberry total
var gt_total_strawberry = 0
var fa_total_strawberry = 0
var sa_total_strawberry = 0

# garlic total
var gt_total_garlic = 0
var fa_total_garlic = 0
var sa_total_garlic = 0

# corn total
var gt_total_corn = 0
var fa_total_corn = 0
var sa_total_corn = 0

# bean total
var gt_total_bean = 0
var fa_total_bean = 0
var sa_total_bean = 0

# sweet_potato total
var gt_total_sweet_potato = 0
var fa_total_sweet_potato = 0
var sa_total_sweet_potato = 0

# tomato total
var gt_total_tomato = 0
var fa_total_tomato = 0
var sa_total_tomato = 0

signal all_stat_refresh
func stat_refresh():
	total_move_speed = base_move_speed + additional_move_speed
	
	# rice
	sa_total_rice = sa_base_rice + sa_add_rice
	gt_total_rice = (GT_BASE_RICE + gt_increase_rice - gt_reduce_rice) * \
	clamp((1 + (gt_increase_percent_rice - gt_reduce_percent_rice)/100.0), 0, 5000)
	fa_total_rice = (FA_BASE_RICE + fa_increase_rice - fa_reduce_rice) * \
	clamp((1 + (fa_increase_percent_rice - fa_reduce_percent_rice)/100.0), 0, 5000)
	
	# wheat
	sa_total_wheat = sa_base_wheat + sa_add_wheat
	gt_total_wheat = (GT_BASE_WHEAT + gt_increase_wheat - gt_reduce_wheat) * \
	clamp((1 + (gt_increase_percent_wheat - gt_reduce_percent_wheat)/100.0), 0, 5000)
	fa_total_wheat = (FA_BASE_WHEAT + fa_increase_wheat - fa_reduce_wheat) * \
	clamp((1 + (fa_increase_percent_wheat - fa_reduce_percent_wheat)/100.0), 0, 5000)
	
	# cabbage
	sa_total_cabbage = sa_base_cabbage + sa_add_cabbage
	gt_total_cabbage = (GT_BASE_CABBAGE + gt_increase_cabbage - gt_reduce_cabbage) * \
	clamp((1 + (gt_increase_percent_cabbage - gt_reduce_percent_cabbage)/100.0), 0, 5000)
	fa_total_cabbage = (FA_BASE_CABBAGE + fa_increase_cabbage - fa_reduce_cabbage) * \
	clamp((1 + (fa_increase_percent_cabbage - fa_reduce_percent_cabbage)/100.0), 0, 5000)
	
	# strawberry
	sa_total_strawberry = sa_base_strawberry + sa_add_strawberry
	gt_total_strawberry = (GT_BASE_STRAWBERRY + gt_increase_strawberry - gt_reduce_strawberry) * \
	clamp((1 + (gt_increase_percent_strawberry - gt_reduce_percent_strawberry)/100.0), 0, 5000)
	fa_total_strawberry = (FA_BASE_STRAWBERRY + fa_increase_strawberry - fa_reduce_strawberry) * \
	clamp((1 + (fa_increase_percent_strawberry - fa_reduce_percent_strawberry)/100.0), 0, 5000)
	
	# garlic
	sa_total_garlic = sa_base_garlic + sa_add_garlic
	gt_total_garlic = (GT_BASE_GARLIC + gt_increase_garlic - gt_reduce_garlic) * \
	clamp((1 + (gt_increase_percent_garlic - gt_reduce_percent_garlic)/100.0), 0, 5000)
	fa_total_garlic = (FA_BASE_GARLIC + fa_increase_garlic - fa_reduce_garlic) * \
	clamp((1 + (fa_increase_percent_garlic - fa_reduce_percent_garlic)/100.0), 0, 5000)
	
	# corn
	sa_total_corn = sa_base_corn + sa_add_corn
	gt_total_corn = (GT_BASE_CORN + gt_increase_corn - gt_reduce_corn) * \
	clamp((1 + (gt_increase_percent_corn - gt_reduce_percent_corn)/100.0), 0, 5000)
	fa_total_corn = (FA_BASE_CORN + fa_increase_corn - fa_reduce_corn) * \
	clamp((1 + (fa_increase_percent_corn - fa_reduce_percent_corn)/100.0), 0, 5000)
	
	# bean
	sa_total_bean = sa_base_bean + sa_add_bean
	gt_total_bean = (GT_BASE_BEAN + gt_increase_bean - gt_reduce_bean) * \
	clamp((1 + (gt_increase_percent_bean - gt_reduce_percent_bean)/100.0), 0, 5000)
	fa_total_bean = (FA_BASE_BEAN + fa_increase_bean - fa_reduce_bean) * \
	clamp((1 + (fa_increase_percent_bean - fa_reduce_percent_bean)/100.0), 0, 5000)
	
	# sweet_potato (FA_BASE 없음 — 방치형이라 별도 처리 필요)
	sa_total_sweet_potato = sa_base_sweet_potato + sa_add_sweet_potato
	gt_total_sweet_potato = (GT_BASE_SWEET_POTATO + gt_increase_sweet_potato - gt_reduce_sweet_potato) * \
	clamp((1 + (gt_increase_percent_sweet_potato - gt_reduce_percent_sweet_potato)/100.0), 0, 5000)
	
	# tomato
	sa_total_tomato = sa_base_tomato + sa_add_tomato
	gt_total_tomato = (GT_BASE_TOMATO + gt_increase_tomato - gt_reduce_tomato) * \
	clamp((1 + (gt_increase_percent_tomato - gt_reduce_percent_tomato)/100.0), 0, 5000)
	fa_total_tomato = (FA_BASE_TOMATO + fa_increase_tomato - fa_reduce_tomato) * \
	clamp((1 + (fa_increase_percent_tomato - fa_reduce_percent_tomato)/100.0), 0, 5000)
	
	emit_signal("all_stat_refresh")
