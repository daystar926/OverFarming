extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var grow_time
var amount
var base_grow_time
var plants_level = 1
var grow_tween: Tween
var flash_tween: Tween
var crop_id: int = 3  # 쌀 = 1
var grid_pos: Vector2i  # 필드 관리자가 심을 때 주입해줌

func _ready() -> void:
	if randi_range(1, 2) == 1:
		animated_sprite_2d.flip_h = true
	Global.all_stat_refresh.connect(plants_setting)
	Global.time_stop_signal.connect(stop_growing)
	Global.time_start_signal.connect(start_growing)
	plants_start()

func plants_setting():
	grow_time = Global.gt_total_cabbage
	amount = Global.fa_total_cabbage

func plants_start():
	plants_setting()
	base_grow_time = grow_time
	_set_level(1)

var growable = true
func stop_growing():
	growable = false

func start_growing():
	growable = true

func _process(delta: float) -> void:
	if not growable:
		return
	if plants_level >= 4:
		return

	base_grow_time -= delta

	var target_level: int = 1
	if base_grow_time <= 0.0:
		target_level = 4
	elif base_grow_time <= grow_time * 0.33:
		target_level = 3
	elif base_grow_time <= grow_time * 0.66:
		target_level = 2

	if target_level > plants_level:
		_set_level(target_level)

func _set_level(new_level: int) -> void:
	plants_level = new_level

	match plants_level:
		1:
			animated_sprite_2d.play("1")
			plants_grow_tween()
			z_as_relative = false
			z_index = -1
		2:
			animated_sprite_2d.play("2")
			plants_grow_tween()
			z_as_relative = false
			z_index = 0
		3:
			animated_sprite_2d.play("3")
			plants_grow_tween()
		4:
			animated_sprite_2d.play("4")
			$Area2D/CollisionShape2D.set_deferred("disabled", false)
			set_process(false)

func plants_grow_tween() -> void:
	if grow_tween and grow_tween.is_valid():
		grow_tween.kill()
	if flash_tween and flash_tween.is_valid():
		flash_tween.kill()

	animated_sprite_2d.scale = Vector2(8, 8)
	animated_sprite_2d.modulate = Color(1, 1, 1, 1)

	grow_tween = create_tween()
	grow_tween.tween_property(animated_sprite_2d, "scale", Vector2(7, 9), 0.05)
	grow_tween.tween_property(animated_sprite_2d, "scale", Vector2(8, 8), 0.08)

	flash_tween = create_tween()
	flash_tween.tween_property(animated_sprite_2d, "modulate", Color(18.892, 18.892, 18.892, 1.0), 0.01)
	flash_tween.tween_property(animated_sprite_2d, "modulate", Color(1, 1, 1, 1.0), 0.12)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_harvest()

func _harvest() -> void:
	Global.stat_refresh()
	var parent = get_tree().current_scene
	var node = parent.get_child(9)
	var item_position = Vector2(grid_pos.x * 128 + 64, grid_pos.y * 128 + 30)
	
	var da_amount = Global.da_amount_cul("cabbage")
	for i in range (da_amount):
		var item = preload("res://scene/plants/plants_item/cabbage_item.tscn").instantiate()
		item.set("spawn_position", item_position)
		node.add_child(item)
	Global.add_sa(crop_id, 1)  # (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	
	self.queue_free()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	Global.add_sa(crop_id, 1)  # 기존 동작 그대로 유지 (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	
	self.queue_free()
