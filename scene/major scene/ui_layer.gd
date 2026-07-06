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
	Global.clear_reward_signal.connect(round_clear)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_label.text = str(Engine.time_scale) + "배속"

var round_clear_check = true

func round_check():
	Global.time_stop()
	if not Global.round_clear_check():
		print("여기서 라운드 클리어 했는지 안했는지 정해짐")
		round_clear_check = false


func round_clear():
	round_clear_check = true



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


func _on_interactive_button_pressed() -> void:
	pass # Replace with function body.
