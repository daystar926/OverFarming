extends Control

@onready var slot_1: Marker2D = $"slot hbox/Control/slot 1"
@onready var slot_2: Marker2D = $"slot hbox/Control2/slot 1"
@onready var slot_3: Marker2D = $"slot hbox/Control3/slot 1"
@onready var slot_4: Marker2D = $"slot hbox/Control4/slot 1"
@onready var slot_5: Marker2D = $"slot hbox/Control5/slot 1"
@onready var slot_6: Marker2D = $"slot hbox/Control6/slot 1"
@onready var slot_7: Marker2D = $"slot hbox/Control7/slot 1"
@onready var slot_8: Marker2D = $"slot hbox/Control8/slot 1"
@onready var slot_9: Marker2D = $"slot hbox/Control9/slot 1"

@onready var marker_array: Array = [
	slot_1, slot_2, slot_3, slot_4, slot_5,
	slot_6, slot_7, slot_8, slot_9,
]
@onready var sa_1: Label = $"slot hbox/Control/MarginContainer/ColorRect/sa 1"
@onready var sa_2: Label = $"slot hbox/Control2/MarginContainer/ColorRect/sa 2"
@onready var sa_3: Label = $"slot hbox/Control3/MarginContainer/ColorRect/sa 3"
@onready var sa_4: Label = $"slot hbox/Control4/MarginContainer/ColorRect/sa 4"
@onready var sa_5: Label = $"slot hbox/Control5/MarginContainer/ColorRect/sa 5"
@onready var sa_6: Label = $"slot hbox/Control6/MarginContainer/ColorRect/sa 6"
@onready var sa_7: Label = $"slot hbox/Control7/MarginContainer/ColorRect/sa 7"
@onready var sa_8: Label = $"slot hbox/Control8/MarginContainer/ColorRect/sa 8"
@onready var sa_9: Label = $"slot hbox/Control9/MarginContainer/ColorRect/sa 9"

var current_selected = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_check()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sa_1.text = str(Global.sa_total_rice)
	sa_2.text = str(Global.sa_total_wheat)
	sa_3.text = str(Global.sa_total_cabbage)
	sa_4.text = str(Global.sa_total_grape)
	sa_5.text = str(Global.sa_total_onion)
	sa_6.text = str(Global.sa_total_corn)
	sa_7.text = str(Global.sa_total_bean)
	sa_8.text = str(Global.sa_total_pumpkin)
	sa_9.text = str(Global.sa_total_tomato)

func _unhandled_input(event: InputEvent) -> void:
	if $"..".is_detail_opened:
		return 
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			current_selected -= 1
			if current_selected == 0:
				current_selected = 9
			selected_check()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			
			current_selected += 1
			if current_selected == 10:
				current_selected = 1
			selected_check()
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				current_selected = 1
				selected_check()
			KEY_2:
				current_selected = 2
				selected_check()
			KEY_3:
				current_selected = 3
				selected_check()
			KEY_4:
				current_selected = 4
				selected_check()
			KEY_5:
				current_selected = 5
				selected_check()
			KEY_6:
				current_selected = 6
				selected_check()
			KEY_7:
				current_selected = 7
				selected_check()
			KEY_8:
				current_selected = 8
				selected_check()
			KEY_9:
				current_selected = 9
				selected_check()


func selected_check() -> void:
	for i in range(marker_array.size()):
		var children = marker_array[i].get_children()
		for child in children:
			child.queue_free()
		
	# 새로운 effect 생성
	var effect_instance = preload("res://script/scene script/selected_effect.tscn").instantiate()
	marker_array[current_selected - 1].add_child(effect_instance)
	print(marker_array[current_selected - 1].get_children())


func _on_slot_1_button_pressed() -> void:
	current_selected = 1
	selected_check()


func _on_slot_2_button_pressed() -> void:
	current_selected = 2
	selected_check()


func _on_slot_3_button_pressed() -> void:
	current_selected = 3
	selected_check()


func _on_slot_4_button_pressed() -> void:
	current_selected = 4
	selected_check()

func _on_slot_5_button_pressed() -> void:
	current_selected = 5
	selected_check()


func _on_slot_6_button_pressed() -> void:
	current_selected = 6
	selected_check()


func _on_slot_7_button_pressed() -> void:
	current_selected = 7
	selected_check()

func _on_slot_8_button_pressed() -> void:
	current_selected = 8
	selected_check()

func _on_slot_9_button_pressed() -> void:
	current_selected = 9
	selected_check()
