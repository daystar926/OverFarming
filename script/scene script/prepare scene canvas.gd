extends CanvasLayer
@onready var pause_con: Control = $"pause con"
@onready var qause_color_mat: ColorRect = $"pause con/qause color mat"
@onready var continue_button: TextureButton = $"pause con/NinePatchRect/continue button"
@onready var option_button: TextureButton = $"pause con/NinePatchRect/option button"
@onready var quit_button: TextureButton = $"pause con/NinePatchRect/quit button"

var is_qaused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		if is_qaused:
			_on_continue_button_pressed()
		else:
			_on_back_button_pressed()
		
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

## 씬 안의 모든 버튼 포커스를 해제해 키 입력 오염을 막는 함수
func disable_button_focus(node: Node) -> void:
	for child in node.get_children():
		if child is BaseButton:
			child.focus_mode = Control.FOCUS_NONE
		disable_button_focus(child)

func _on_back_button_pressed() -> void:
	is_qaused = true
	pause_panel_show()
	disable_button_focus(self)


func _on_continue_button_pressed() -> void:
	continue_button.focus_mode = Control.FOCUS_NONE
	option_button.focus_mode = Control.FOCUS_NONE
	quit_button.focus_mode = Control.FOCUS_NONE
	continue_button.disabled = true
	option_button.disabled = true
	quit_button.disabled = true
	pause_panel_hide()
	disable_button_focus(self)
	is_qaused = false

func _on_option_button_pressed() -> void:
	GlobalCanvas.dev_alert_1()


func _on_quit_button_pressed() -> void:
	GlobalCanvas.white_transition("res://scene/major scene/main lobby.tscn")
