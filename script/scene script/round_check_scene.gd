extends Control

@onready var bg_color: ColorRect = $"bg color"
@onready var round_label: Label = $"round label"
@onready var label_1: Label = $"label 1"
@onready var label_2: Label = $"Label 2"
@onready var label_3: Label = $"Label 3"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	round_label.text = "ROUND " + str(Global.current_round)
	label_2.text = "보유 수확량: " + str(Global.current_yield) + "kg"
	label_3.text = "필요 수확량: " + str(Global.clear_requirments[Global.current_round]) + "kg"
	animation_play()
	
var is_pressable = false
func animation_play():
	Engine.time_scale = 1
	animation_player.play("1")
	await animation_player.animation_finished
	print("if 진입 전")

	if Global.round_clear:
		print("if 문 진입")
		animation_player.play("clear")
		await animation_player.animation_finished
		is_pressable = true
	else:
		animation_player.play("game over")
		await animation_player.animation_finished
		is_pressable = true



func _input(event: InputEvent) -> void:
	var is_key_press = event is InputEventKey and event.pressed and not event.is_echo()
	var is_mouse_press = event is InputEventMouseButton and event.pressed
	
	if is_pressable:
		if is_key_press or is_mouse_press:
			if Global.round_clear:
				print("if 문 진입")
				animation_player.play("clear_2")
			else:
				animation_player.play("game over_2")
			get_viewport().set_input_as_handled()

func _on_button_pressed() -> void:
	pass


func _on_button_2_pressed() -> void:
	animation_player.play("clear")
