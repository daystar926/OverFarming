extends Control
@onready var book_sprite: AnimatedSprite2D = $"playerble map/book/book sprite"
@onready var shelf_sprite: AnimatedSprite2D = $"playerble map/shelf/shelf sprite"
@onready var game_start_label: Label = $"playerble map/stairs/game start label"
@onready var book_label: Label = $"playerble map/book/book label"
@onready var shelf_label: Label = $"playerble map/shelf/shelf label"
@onready var book_panel: NinePatchRect = $"playerble map/book/book panel"
@onready var shelf_panel: NinePatchRect = $"playerble map/shelf/shelf panel"
@onready var game_start_panel: NinePatchRect = $"playerble map/stairs/game start panel"
@onready var tuto_label: Label = $"CanvasLayer/tuto label"
@onready var skin_left_button: TextureButton = $"CanvasLayer/skin change con/skin left button"
@onready var skin_right_button: TextureButton = $"CanvasLayer/skin change con/skin right button"
@onready var skin_name_label: Label = $"CanvasLayer/skin change con/skin name label"

@onready var skin_apply_button: TextureButton = $"CanvasLayer/skin change con/skin apply button"

var ui_selected = 0 # 0은 아무것도 아님, 1은 도감, 2는 기본 아이템, 3은 게임 시작

func _ready() -> void:
	AudioManager.play_bgm("lobby")

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("SPACEBAR"):
		match ui_selected:
			0:
				return
			1:
				GlobalCanvas.dev_alert_1()
			2:
				skin_change_mod()
			3:
				GlobalCanvas.white_transition("res://scene/major scene/main_game.tscn")

func skin_change_mod():
	Global.skin_change()
	tuto_label_hide()
	var tween = create_tween()
	tween.tween_property(skin_left_button, "scale", Vector2(1,1) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_right_button, "scale", Vector2(1,1) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_name_label, "scale", Vector2(1,1) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_apply_button, "scale", Vector2(1,1) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_callback(func():
		skin_left_button.disabled = false
		skin_right_button.disabled = false
		).set_delay(0.25)

func skin_change_mod_exit():
	skin_left_button.disabled = true
	skin_right_button.disabled = true
	Global.skin_change()
	tuto_label_hide()
	var tween = create_tween()
	tween.tween_property(skin_left_button, "scale", Vector2(0,0) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_right_button, "scale",Vector2(0,0) , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_name_label, "scale", Vector2(0,0)  , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)
	tween.parallel().tween_property(skin_apply_button, "scale", Vector2(0,0)  , 0.5)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)


func tuto_label_hide():
	var tween = create_tween()
	tween.tween_property(tuto_label, "position", Vector2(-500, 687), 0.4)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUART)

func tuto_label_show():
	var tween = create_tween()
	tween.tween_property(tuto_label, "position", Vector2(47, 687), 0.4)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUART)

func title_show_tween(node):
	var tween = create_tween()
	tween.tween_property(node, "modulate", Color(1,1,1,1), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUAD)
	
func title_hide_tween(node):
	var tween = create_tween()
	tween.tween_property(node, "modulate", Color(1,1,1,0), 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_QUAD)

func ddiyong_tween(node):
	node.scale = Vector2(8, 8)
	var current_scale = Vector2(8, 8)
	var target_scale = Vector2(current_scale.x * 0.8, current_scale.y * 1.4)
	
	var tween = create_tween()
	tween.tween_property(node, "scale", target_scale, 0.05)
	tween.tween_property(node, "scale", current_scale, 0.05)

func _on_book_area_entered(area: Area2D) -> void:
	print(area)
	if not area.is_in_group("player"):
		return
	ddiyong_tween(book_sprite)
	book_sprite.play("open")
	
	title_show_tween(book_label)
	title_show_tween(book_panel)
	ui_selected = 1
	
func _on_book_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	book_sprite.play("close")
	ddiyong_tween(book_sprite)
	title_hide_tween(book_label)
	title_hide_tween(book_panel)
	ui_selected = 0

func _on_shelf_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("open")
	ddiyong_tween(shelf_sprite)
	title_show_tween(shelf_label)
	title_show_tween(shelf_panel)
	ui_selected = 2

func _on_shelf_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("close")
	ddiyong_tween(shelf_sprite)
	title_hide_tween(shelf_label)
	title_hide_tween(shelf_panel)
	ui_selected = 0
	
func _on_stairs_area_entered(area: Area2D) -> void:
	title_show_tween(game_start_label)
	title_show_tween(game_start_panel)
	ui_selected = 3

func _on_stairs_area_exited(area: Area2D) -> void:
	title_hide_tween(game_start_label)
	title_hide_tween(game_start_panel)
	ui_selected = 0


func _on_skin_left_button_pressed() -> void:
	Global.tween_ddiyong($"CanvasLayer/skin change con/skin left button")
	if Global.start_item == Global.start_item_list.size():
		Global.start_item = 1
	else:
		Global.start_item += 1
	skin_name_change()
	Global.start_item_change()

func _on_skin_right_button_pressed() -> void:
	Global.tween_ddiyong($"CanvasLayer/skin change con/skin right button")
	if Global.start_item == 1:
		Global.start_item = 2
	else:
		Global.start_item -= 1
	skin_name_change()
	Global.start_item_change()

func skin_name_change():
	skin_name_label.text = str(Global.start_item_name[Global.start_item])

func _on_skin_apply_button_pressed() -> void:
	Global.tween_ddiyong($"CanvasLayer/skin change con/skin apply button")
	skin_change_mod_exit()
	tuto_label_show()
	Global.skin_change_finish()
	
