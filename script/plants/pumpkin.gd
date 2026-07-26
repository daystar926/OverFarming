extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var grow_time
var amount
var base_grow_time
var plants_level = 1
var grow_tween: Tween
var flash_tween: Tween
var crop_id: int = 8  # 쌀 = 1
var grid_pos: Vector2i  # 필드 관리자가 심을 때 주입해줌

var last_plants_level: int = 0

func _ready() -> void:
	if randi_range(1, 2) == 1:
		animated_sprite_2d.flip_h = true
	Global.time_stop_signal.connect(stop_growing)
	Global.time_start_signal.connect(start_growing)
	Global.all_stat_refresh.connect(plants_setting)
	plants_start()

func plants_setting():
	grow_time = Global.gt_total_pumpkin
	amount = Global.fa_total_pumpkin

func plants_start():
	plants_setting()
	base_grow_time = grow_time
	plants_level_check()

var growable = true

func stop_growing():
	growable = false

func start_growing():
	growable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if growable:
		base_grow_time -= delta
		if base_grow_time <= 0:
			plants_level = 7
		elif base_grow_time <= grow_time * 0.10:
			plants_level = 6
		elif base_grow_time <= grow_time * 0.25:
			plants_level = 5
		elif base_grow_time <= grow_time * 0.50:
			plants_level = 4
		elif base_grow_time <= grow_time * 0.66:
			plants_level = 3
		elif base_grow_time <= grow_time * 0.82:
			plants_level = 2
		plants_level_check()

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

func plants_level_check():
	if plants_level != last_plants_level:
		last_plants_level = plants_level
		
		match plants_level:
			1:
				animated_sprite_2d.play("1")
				z_as_relative = false
				plants_grow_tween()
				z_index = -1
			2:
				animated_sprite_2d.play("2")
				z_as_relative = false
				plants_grow_tween()
				z_index = 0
			3:
				animated_sprite_2d.play("3")
				plants_grow_tween()
			4:
				animated_sprite_2d.play("4")
				$Area2D/CollisionShape2D.disabled = false
				plants_grow_tween()
			5:
				animated_sprite_2d.play("5")
				plants_grow_tween()
			6:
				animated_sprite_2d.play("6")
				plants_grow_tween()
			7:
				animated_sprite_2d.play("7")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_harvest()

func _harvest() -> void:
	Global.stat_refresh()
	var parent = get_tree().current_scene
	var node = parent.get_child(9)
	var item_position = Vector2(grid_pos.x * 128 + 64, grid_pos.y * 128 + 30)
	var da_amount = Global.da_amount_cul("pumpkin")
	for i in range (da_amount):
		var item = preload("res://scene/plants/plants_item/pumpkin_item.tscn").instantiate()
		item.set("spawn_position", item_position)
		item.pumpkin_level_set(plants_level)
		node.add_child(item)
	
	# 펌킨 새끼한테 넘길때 펌킨 레벨 데이터 셋 해주기
	Global.add_sa(crop_id, 1)  # 기존 동작 그대로 유지 (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	AudioManager.play_sfx("yield", 0.15)
	self.queue_free()

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	Global.add_sa(crop_id, 1)  # 기존 동작 그대로 유지 (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	
	self.queue_free()
