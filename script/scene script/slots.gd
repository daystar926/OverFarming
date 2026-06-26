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

@onready var maker_array: Array = [
	slot_1, slot_2, slot_3, slot_4, slot_5,
	slot_6, slot_7, slot_8, slot_9,
]

var current_selected = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_check()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			current_selected += 1
			if current_selected == 10:
				current_selected = 1
			selected_check()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			current_selected -= 1
			if current_selected == 0:
				current_selected = 9
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
#
###########################
# 여러번 누르면 셀렉티드 여러번 인스턴스 되는 버그 발견 @!!@!@@@!
#####################

func selected_check():
	for i in range(maker_array.size()):
		if i == current_selected - 1:
			continue
		for child in maker_array[i].get_children():
			if child.name.begins_with("selected effect"):
				child.queue_free()
	
	var effect_instance = preload("res://script/scene script/selected_effect.tscn").instantiate()
	maker_array[current_selected - 1].add_child(effect_instance)
