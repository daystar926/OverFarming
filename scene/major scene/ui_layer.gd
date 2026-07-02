extends CanvasLayer

@onready var main_character: CharacterBody2D = $"../Main Character"
@onready var debug_label: Label = $"debug con/debug label"
@onready var yield_label: Label = $UI/yield

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.yield_changed.connect(yield_changed)
	yield_label.text = str(Global.current_yield) + "Kg"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug_label.text = str(Engine.time_scale) + "배속"


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
