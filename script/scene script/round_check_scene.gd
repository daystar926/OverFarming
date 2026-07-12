extends Control

@onready var bg_color: ColorRect = $"bg color"
@onready var round_label: Label = $"round label"
@onready var label_1: Label = $"label 1"
@onready var label_2: Label = $"Label 2"
@onready var label_3: Label = $"Label 3"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	round_label.text = "ROUND " + str(Global.current_round)
	label_2.text = "보유 골드: " + str(Global.format_num_custom(Global.current_gold)) + " G"
	label_3.text = "필요 골드: " + str(Global.format_num_custom(Global.clear_requirments[Global.current_round])) + " G"
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



func animation_pass():

	if Global.round_clear:
		print("if 문 진입")
		animation_player.play("clear_2")
		is_pressable = false
	else:
		animation_player.play("game over_2")
		is_pressable = false


func _on_button_pressed() -> void:
	pass


func _on_button_2_pressed() -> void:
	animation_player.play("clear")

func reward_scene_ins():
	var reward_scene = preload("res://scene/reward_scene.tscn").instantiate()
	add_child(reward_scene)
	reward_scene.reward_exit.connect(round_check_exit)

signal rcs_exit
func round_check_exit():
	animation_player.play("round check exit anim")
	await animation_player.animation_finished
	Global.current_round += 1
	rcs_exit.emit()
	queue_free()
