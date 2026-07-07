extends CanvasLayer

@onready var main_character: CharacterBody2D = $"../Main Character"
@onready var debug_label: Label = $"debug con/debug label"
@onready var yield_label: Label = $UI/yield
@onready var time_modulate: CanvasModulate = $"../CanvasModulate"
@onready var debug_label_2: Label = $"debug con/debug label2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.yield_changed.connect(yield_changed)
	yield_label.text = str(Global.current_yield) + "Kg"
	time_modulate.time_tick.connect(set_daytime)
	time_modulate.night_time.connect(round_check)

	Global.ui_hide_signal.connect(ui_hide)
	Global.ui_show_signal.connect(ui_show)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_label.text = str(Engine.time_scale) + "배속"

func round_check():
	Global.time_stop()
	Global.round_clear_check()
	Global.ui_hide()
	var rcs = preload("res://scene/round_check_scene.tscn").instantiate()
	add_child(rcs)






func set_daytime(day, hour, minute):
	debug_label_2.text = str(day) + "번째 날, " + str(hour) + "시 " + str(minute) + "분"

func yield_changed():
	yield_label.text = str(Global.current_yield) + "Kg"
	Global.tween_ddiyong(yield_label)

func _on_button_pressed() -> void:
	pass

var current_time_scale = 1
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("speed_up"):
		if current_time_scale >= 3:
			return
		current_time_scale += 1
		engine_speed_setting()
	elif Input.is_action_just_pressed("speed_down"):
		if current_time_scale <= 1:
			return
		current_time_scale -= 1
		engine_speed_setting()
			
func engine_speed_setting():
	Engine.time_scale = current_time_scale


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
	tween.parallel().tween_property(ui, "position", Vector2(-500, 0), 1)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)

func ui_show():
	var tween = create_tween()
	tween.tween_property(slots, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(ui, "position", Vector2(0, 0), 0.6)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
		
		
		
		
		
		
		
