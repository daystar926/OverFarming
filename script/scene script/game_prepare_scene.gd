extends Control
@onready var book_sprite: AnimatedSprite2D = $"playerble map/book/book sprite"
@onready var shelf_sprite: AnimatedSprite2D = $"playerble map/shelf/shelf sprite"
@onready var game_start_label: Label = $"playerble map/stairs/game start label"
@onready var book_label: Label = $"playerble map/book/book label"
@onready var shelf_label: Label = $"playerble map/shelf/shelf label"

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
	var current_scale = node.scale
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
	
func _on_book_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	book_sprite.play("close")
	ddiyong_tween(book_sprite)
	title_hide_tween(book_label)

func _on_shelf_area_entered(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("open")
	ddiyong_tween(shelf_sprite)
	title_show_tween(shelf_label)

func _on_shelf_area_exited(area: Area2D) -> void:
	if not area.is_in_group("player"):
		return
	shelf_sprite.play("close")
	ddiyong_tween(shelf_sprite)
	title_hide_tween(shelf_label)
	
func _on_stairs_area_entered(area: Area2D) -> void:
	title_show_tween(game_start_label)


func _on_stairs_area_exited(area: Area2D) -> void:
	title_hide_tween(game_start_label)
