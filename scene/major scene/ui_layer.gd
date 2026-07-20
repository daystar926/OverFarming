extends CanvasLayer
@onready var setting_ui: Control = $"setting UI"

@onready var main_character: CharacterBody2D = $"../Main Character"
@onready var debug_label: Label = $"debug con/debug label"
@onready var gold_label: Label = $UI/yield
@onready var time_modulate: CanvasModulate = $"../CanvasModulate"
@onready var debug_label_2: Label = $"debug con/debug label2"
@onready var speed_button: TextureButton = $"setting UI/HBoxContainer/speed button"
var time_controlable = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.gold_changed.connect(gold_changed)
	gold_label.text = str(Global.current_gold) + " G"
	time_modulate.time_tick.connect(set_daytime)
	time_modulate.night_time.connect(round_check)

	Global.ui_hide_signal.connect(ui_hide)
	Global.ui_show_signal.connect(ui_show)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_label.text = "이속: " + str(Global.total_move_speed)

func round_check():
	current_time_scale = 1
	engine_speed_setting()
	
	Global.time_stop()
	Global.round_clear_check()
	Global.ui_hide()
	time_controlable = false
	var rcs = preload("res://scene/round_check_scene.tscn").instantiate()
	add_child(rcs)
	rcs.rcs_exit.connect(next_day_start)
	

func next_day_start():
	time_modulate.go_to_next_morning()
	Global.ui_show()
	Global.time_start()
	time_controlable = true



func set_daytime(day, hour, minute):
	debug_label_2.text = str(day) + "번째 날, " + str(hour) + "시 " + str(minute) + "분"
	
	
	
func gold_changed():
	gold_label.text = str(Global.current_gold) + " G"
	Global.tween_ddiyong(gold_label)

func _on_button_pressed() -> void:
	Global.additional_move_speed += 30
	Global.stat_refresh()

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
	tween.tween_property(slots, "position", Vector2(0, 250), 0.6)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(ui, "position", Vector2(-500, 0), 0.6)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)

func ui_show():
	gold_label.text = str(Global.current_gold) + " G"
	var tween = create_tween()
	tween.tween_property(slots, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
		
		
		
		
		


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
