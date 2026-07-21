extends Control
@onready var book_sprite: AnimatedSprite2D = $"playerble map/book/book sprite"
@onready var shelf_sprite: AnimatedSprite2D = $"playerble map/shelf/shelf sprite"
@onready var game_start_label: Label = $"playerble map/stairs/game start label"
@onready var book_label: Label = $"playerble map/book/book label"
@onready var shelf_label: Label = $"playerble map/shelf/shelf label"

var ui_selected = 0 # 0은 아무것도 아님, 1은 도감, 2는 기본 아이템, 3은 게임 시작

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("SPACEBAR"):
		match ui_selected:
			0:
				return
			1:
				pass # 여기에 도감 입력
			2:
				pass # 여기에 시작 아이템 입력
			3:
				GlobalCanvas.white_transition("res://scene/major scene/main_game.tscn")


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
	ui_selected = 1
	
func _on_book_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	book_sprite.play("close")
	ddiyong_tween(book_sprite)
	title_hide_tween(book_label)
	ui_selected = 0

func _on_shelf_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("open")
	ddiyong_tween(shelf_sprite)
	title_show_tween(shelf_label)
	ui_selected = 2

func _on_shelf_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("close")
	ddiyong_tween(shelf_sprite)
	title_hide_tween(shelf_label)
	ui_selected = 0
	
func _on_stairs_area_entered(area: Area2D) -> void:
	title_show_tween(game_start_label)
	ui_selected = 3

func _on_stairs_area_exited(area: Area2D) -> void:
	title_hide_tween(game_start_label)
	ui_selected = 0
