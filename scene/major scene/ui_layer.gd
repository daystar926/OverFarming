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
@onready var debug_label_2: Label = $"debug con/debug label2"
@onready var speed_button: TextureButton = $"setting UI/HBoxContainer/speed button"
@onready var time_image: TextureRect = $"UI/clork/time image"
@onready var qause_color_mat: ColorRect = $"pause con/qause color mat"

var time_controlable = true
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Global.gold_changed.connect(gold_changed)
	gold_changed()
	time_modulate.time_tick.connect(set_daytime)
	time_modulate.night_time.connect(round_check)
	Global.ui_hide_signal.connect(ui_hide)
	Global.ui_show_signal.connect(ui_show)
	onready_text_anim()
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
	debug_label_2.text = str(day) + "번째 날, " + str(hour) + "시 " + str(minute) + "분"
	
	
	
func gold_changed():
	gold_label.text = str(Global.format_num_custom(Global.current_gold)) + " G"
	goal_gold.text = str(Global.format_num_custom(Global.clear_requirments[Global.current_round])) + " G"
	Global.tween_ddiyong(gold_label)
	
func _on_button_pressed() -> void:
	Global.additional_move_speed += 30
	Global.stat_refresh()

var is_qaused = false
var current_time_scale = 1
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
			if is_qaused:
				_on_continue_button_pressed()
			else:
				_on_back_button_pressed()


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
