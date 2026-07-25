extends Control

@onready var bg_color: ColorRect = $"bg color"
@onready var round_label: Label = $"round label"
@onready var label_1: Label = $"label 1"
@onready var label_2: Label = $"Label 2"
@onready var label_3: Label = $"Label 3"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# ================== 게임 결과 노드 ====================

@onready var go_round_label: RichTextLabel = $"go round label"
@onready var go_play_time_label: RichTextLabel = $"go play time label"
@onready var go_total_plants_label: RichTextLabel = $"go total plants label"
@onready var go_total_gold_label: RichTextLabel = $"go total gold label"

@onready var grid_container: GridContainer = $"inven panel/MarginContainer/ScrollContainer/GridContainer"
@onready var inven_panel: Control = $"inven panel"


func _ready() -> void:
	round_label.text = "DAY " + str(Global.current_round)
	label_2.text = "보유 골드: " + str(Global.format_num_custom(Global.current_gold)) + " G"
	label_3.text = "필요 골드: " + str(Global.format_num_custom(Global.clear_requirments[Global.current_round])) + " G"
	Global.current_gold -= Global.clear_requirments[Global.current_round]
	animation_play()
	
var is_pressable = false

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_COMMA):
		return
	if Input.is_key_pressed(KEY_PERIOD):
		return

func animation_play():
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


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "game over_2":
		animation_player.play("game over_3")
	elif anim_name == "game over_3":
		animation_player.play("game over_4")
		inven_refresh()

#
#@onready var go_round_label: RichTextLabel = $"go round label"
#@onready var go_play_time_label: RichTextLabel = $"go play time label"
#@onready var go_total_plants_label: RichTextLabel = $"go total plants label"
#@onready var go_total_gold_label: RichTextLabel = $"go total gold label"

func game_result_label_setting():
	var final_round = " 최종 라운드: " + str(Global.current_round) + " 라운드"
	var play_time = " 플레이 시간: " + str(Global.format_time(int(Global.play_time)))
	var total_plants = " 작물 재배 횟수: " + str(Global.format_with_commas(Global.total_plants)) + " 회"
	var total_gold = "\n 획득한 골드량: " + str(Global.format_num_custom(Global.total_gold)) + " G"
	
	var tween = create_tween()
	tween.tween_callback(func(): go_round_label.type_text(final_round))
	tween.tween_interval(0.1)
	tween.tween_callback(func(): go_play_time_label.type_text(play_time))
	tween.tween_interval(0.1)
	tween.tween_callback(func(): go_total_plants_label.type_text(total_plants))
	tween.tween_interval(0.1)
	tween.tween_callback(func(): go_total_gold_label.type_text(total_gold))
	
	
	
	
func inven_refresh():
	for child in grid_container.get_children():
		child.queue_free()

	for item in Global.item_inventory:
		var slot = preload("res://scene/inventory_slot_2.tscn").instantiate()
		grid_container.add_child(slot)
		slot.set_item(item)
	
	
	
	
	
func cry():
	Global.cry()
	
func inven_show():
	var tween = create_tween()
	tween.tween_property(inven_panel, "position", Vector2(472, 90), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	
	
func inven_hide():
	var tween = create_tween()
	tween.tween_property(inven_panel, "position", Vector2(472, 1300), 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)
	
	


func _on_item_check_button_pressed() -> void:
	inven_show()


func _on_inven_close_button_pressed() -> void:
	inven_hide()


func _on_retry_button_pressed() -> void:
	Global.reset_for_new_game()
	GlobalCanvas.white_transition("res://scene/major scene/main_game.tscn")
	


func _on_main_menu_button_pressed() -> void:
	GlobalCanvas.white_transition("res://scene/major scene/main lobby.tscn")
