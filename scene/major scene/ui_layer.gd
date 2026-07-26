extends CanvasLayer
@onready var setting_ui: Control = $"setting UI"
@onready var gold_label: Label = $"UI/gold panel/yield"
@onready var pause_con: Control = $"pause con"
@onready var continue_button: TextureButton = $"pause con/NinePatchRect/continue button"
@onready var option_button: TextureButton = $"pause con/NinePatchRect/option button"
@onready var quit_button: TextureButton = $"pause con/NinePatchRect/quit button"
@onready var goal_gold: Label = $"UI/gold panel/goal gold"
@onready var day_label: RichTextLabel = $"round ui/day label"
@onready var main_character: CharacterBody2D = $"../Main Character"
@onready var debug_label: Label = $"debug con/debug label"
@onready var time_modulate: CanvasModulate = $"../CanvasModulate"
@onready var current_gold: Label = $Control/yield

@onready var speed_button: TextureButton = $"setting UI/HBoxContainer/speed button"
@onready var time_image: TextureRect = $"UI/clork/time image"
@onready var qause_color_mat: ColorRect = $"pause con/qause color mat"
@onready var coin_anim: AnimatedSprite2D = $"Control/coin anim"
@onready var debug_label_2: Label = $"Control/debug label2"
@onready var day_label2: Label = $"../labels/day"
@onready var goal_gold_label: Label = $"../labels/goal gold"

var time_controlable = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Global.reset_for_new_game()
	Global.gold_changed.connect(gold_changed)
	gold_changed()
	time_modulate.time_tick.connect(set_daytime)
	time_modulate.night_time.connect(round_check)
	Global.ui_hide_signal.connect(ui_hide)
	Global.ui_show_signal.connect(ui_show)
	onready_text_anim()
	
	coin_anim.play("default")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_label.text = "이속: " + str(Global.total_move_speed)

## 씬 안의 모든 버튼 포커스를 해제해 키 입력 오염을 막는 함수
func disable_button_focus(node: Node) -> void:
	for child in node.get_children():
		if child is BaseButton:
			child.focus_mode = Control.FOCUS_NONE
		disable_button_focus(child)

func round_check():
	
	
	current_time_scale = 1
	engine_speed_setting()
	AudioManager.play_sfx("day over")
	time_modulate.fast_forward_to(Global.current_round, 23, 0)
	
	Global.time_stop()
	Global.round_clear_check()
	Global.ui_hide()
	gold_changed()
	time_controlable = false
	var rcs = preload("res://scene/round_check_scene.tscn").instantiate()
	add_child(rcs)
	rcs.rcs_exit.connect(next_day_start)
	

func next_day_start():
	time_modulate.go_to_next_morning()
	await $"../actual field/Main Character".zoom_for_ch()
	# 다음 라운드 애니메이션 나온 뒤에 아래 실행
	morning_text_anim()
	Global.ui_show()
	Global.time_start()
	gold_changed()
	time_controlable = true

func onready_text_anim():
	day_label.text = "[wave amp=150 freq=10 connected=1]DAY " + str(Global.current_round)
	var tween = create_tween()
	tween.tween_property(day_label, "position", Vector2(551, 80), 0.35)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)\
		.set_delay(1)
	tween.tween_interval(1.5)
	tween.tween_property(day_label, "position", Vector2(551, -550), 0.35)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)

func morning_text_anim():
	day_label.text = "[wave amp=150 freq=10 connected=1]DAY " + str(Global.current_round)
	var tween = create_tween()
	tween.tween_property(day_label, "position", Vector2(551, 80), 0.35)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.tween_interval(1.5)
	tween.tween_property(day_label, "position", Vector2(551, -550), 0.35)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)



func set_daytime(day, hour, minute):
	
	if hour == 12:
		debug_label_2.text = "오후 12시 " + str(minute) + "분"
	elif hour > 12:
		debug_label_2.text = "오후 " + str(hour - 12) + "시 " + str(minute) + "분"
	else:
		debug_label_2.text = "오전 " + str(hour) + "시 " + str(minute) + "분"
	
	
	
	
func gold_changed():
	current_gold.text = str(Global.format_num_custom(Global.current_gold)) + " G"
	goal_gold.text = str(Global.format_num_custom(Global.clear_requirments[Global.current_round])) + " G"
	Global.tween_ddiyong(gold_label)
	day_label2.text = "DAY " + str(Global.current_round)
	goal_gold_label.text = "목표 금액: " + str(Global.format_num_custom(Global.clear_requirments[Global.current_round])) + " G"
	
func _on_button_pressed() -> void:
	Global.additional_move_speed += 30
	Global.stat_refresh()

var is_qaused = false
var current_time_scale = 1
var is_detail_opened = false
func _input(event: InputEvent) -> void:
	if not time_controlable:
		return
	if event.is_action_pressed("tab"):
		if not is_qaused:
			if is_detail_opened:
				_on_detail_panel_close_button_pressed()
				get_viewport().set_input_as_handled()
			else:
				detail_panel_open()
				get_viewport().set_input_as_handled()

func _unhandled_input(event: InputEvent) -> void:
	if time_controlable:
		if Input.is_action_just_pressed("speed_up"):
			if current_time_scale >= 3:
				return
			current_time_scale += 1
			engine_speed_setting()
		elif Input.is_action_just_pressed("speed_down"):
			if current_time_scale <= 0:
				return
			current_time_scale -= 1
			engine_speed_setting()
		elif Input.is_action_just_pressed("escape"):
			if not is_detail_opened:
				if is_qaused:
					_on_continue_button_pressed()
				else:
					_on_back_button_pressed()
			if is_detail_opened:
				
				_on_detail_panel_close_button_pressed()
				get_viewport().set_input_as_handled()


func engine_speed_setting(): # 시간 배속 감속 잠금은 클리어씬 소환함수, next_day_start() 함수에서 처리
	
	Engine.time_scale = current_time_scale
	match current_time_scale:
		0:
			speed_button.texture_normal = preload("res://Assets/images/UI/icon pause.png")
			speed_button.texture_pressed = preload("res://Assets/images/UI/icon pause.png")
			speed_button.texture_hover = preload("res://Assets/images/UI/icon pause.png")
		1:
			speed_button.texture_normal = preload("res://Assets/images/UI/icon time scale 1.png")
			speed_button.texture_pressed = preload("res://Assets/images/UI/icon time scale 1.png")
			speed_button.texture_hover = preload("res://Assets/images/UI/icon time scale 1.png")
		2:
			speed_button.texture_normal = preload("res://Assets/images/UI/icon time scale 2.png")
			speed_button.texture_pressed = preload("res://Assets/images/UI/icon time scale 2.png")
			speed_button.texture_hover = preload("res://Assets/images/UI/icon time scale 2.png")
		3:
			speed_button.texture_normal = preload("res://Assets/images/UI/icon time scale 3.png")
			speed_button.texture_pressed = preload("res://Assets/images/UI/icon time scale 3.png")
			speed_button.texture_hover = preload("res://Assets/images/UI/icon time scale 3.png")


func _on_button_2_pressed() -> void:
	time_modulate.go_to_next_morning()
	Global.time_start()

@onready var slots: Control = $slots
@onready var ui: Control = $UI

func ui_hide():
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(slots, "position", Vector2(0, 250), 0.6)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(ui, "position", Vector2(-550, 0), 0.6)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)


func ui_show():
	gold_label.text = str(Global.current_gold) + " G"
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(slots, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)


func pause_panel_show():
	
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(pause_con, "position", Vector2(0, 0), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(qause_color_mat, "color", Color(0,0,0, 0.3), 0.3)
	tween.tween_callback(func():
		continue_button.focus_mode = Control.FOCUS_ALL
		option_button.focus_mode = Control.FOCUS_ALL
		quit_button.focus_mode = Control.FOCUS_ALL
		continue_button.disabled = false
		option_button.disabled = false
		quit_button.disabled = false
	)


func pause_panel_hide():

	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(pause_con, "position", Vector2(0, 1080), 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(qause_color_mat, "color", Color(0,0,0, 0), 0.3)
		

func _on_speed_button_pressed() -> void:
	if current_time_scale >= 3:
		current_time_scale = 0
	else:
		current_time_scale += 1
	engine_speed_setting()


func _on_ui_show_area_2d_area_entered(area: Area2D) -> void:
	ui_show()


func _on_ui_show_area_2d_area_exited(area: Area2D) -> void:
	ui_hide()
	

var ex_time_scale

func _on_back_button_pressed() -> void:
	is_qaused = true
	$"pause con/NinePatchRect/retry button/Label".text = "재시도"
	pause_panel_show()
	disable_button_focus(self)
	ex_time_scale = current_time_scale
	current_time_scale = 0
	engine_speed_setting()


func _on_continue_button_pressed() -> void:
	continue_button.focus_mode = Control.FOCUS_NONE
	option_button.focus_mode = Control.FOCUS_NONE
	quit_button.focus_mode = Control.FOCUS_NONE
	continue_button.disabled = true
	option_button.disabled = true
	quit_button.disabled = true
	pause_panel_hide()
	disable_button_focus(self)
	current_time_scale = ex_time_scale
	engine_speed_setting()
	is_qaused = false
	retry_count = false

func _on_option_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()


func _on_quit_button_pressed() -> void:
	current_time_scale = 1
	engine_speed_setting()
	GlobalCanvas.white_transition("res://scene/major scene/game_prepare_scene.tscn")


var retry_count = false
func _on_retry_button_pressed() -> void:
	if retry_count:
		current_time_scale = 1
		engine_speed_setting()
		Global.reset_for_new_game()
		GlobalCanvas.white_transition("res://scene/major scene/main_game.tscn")
	else:
		$"pause con/NinePatchRect/retry button/Label".text = "진짜로?"
		retry_count = true





@onready var detail: Control = $detail
@onready var inventory_button: TextureButton = $"detail/inventory button"
@onready var stat_button: TextureButton = $"detail/stat button"
@onready var guidebook_button: TextureButton = $"detail/guidebook button"
@onready var detail_panel_close_button: TextureButton = $"detail/detail panel close button"
@onready var inven_grid: GridContainer = $"detail/panel/inven con/ScrollContainer/inven grid"
@onready var inven_msg_label: Label = $"detail/panel/inven con/inven msg label"

@onready var detail_buttons: Array = [inventory_button, stat_button, guidebook_button, detail_panel_close_button]
@onready var inven_con: MarginContainer = $"detail/panel/inven con"
@onready var stat_con: MarginContainer = $"detail/panel/stat con"
@onready var guidebook_con: MarginContainer = $"detail/panel/guidebook con"


######################### 인벤 패널 ##########################

func detail_panel_open():
	inven_refresh()
	is_detail_opened = true
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(detail, "position", Vector2(0,0), 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_callback(func():button_enable()).set_delay(0.3)
	ex_time_scale = current_time_scale
	current_time_scale = 0
	engine_speed_setting()


func _on_detail_panel_close_button_pressed() -> void:
	is_detail_opened = false
	button_disable()
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(detail, "position", Vector2(0,-1200), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	current_time_scale = ex_time_scale
	engine_speed_setting()

func button_enable():
	for buttons in detail_buttons:
		buttons.disabled = false
		
func button_disable():
	for buttons in detail_buttons:
		buttons.disabled = true

const SLOT_SCENE: PackedScene = preload("res://scene/detail_inven_slot.tscn")


func inven_refresh() -> void:
	inven_msg_label.visible = false
	# 즉시 떼어낸 뒤 삭제해야 다음 줄의 add_child와 섞이지 않습니다
	for child in inven_grid.get_children():
		inven_grid.remove_child(child)
		child.queue_free()

	for item in Global.item_inventory:
		var slot = SLOT_SCENE.instantiate()
		inven_grid.add_child(slot)
		slot._set_item_data(item)

	inven_msg_label.visible = Global.item_inventory.is_empty()
	await get_tree().process_frame


func _on_inventory_button_pressed() -> void:
	inven_con.visible = true
	stat_con.visible = false
	guidebook_con.visible = false


func _on_stat_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()
	inven_con.visible = false
	stat_con.visible = true
	guidebook_con.visible = false


func _on_guidebook_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()
	inven_con.visible = false
	stat_con.visible = false
	guidebook_con.visible = true
