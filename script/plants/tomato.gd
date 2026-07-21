extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var grow_time
var amount
var base_grow_time
var plants_level = 1
var bgt
var current_bgt
var crop_id: int = 9  # 쌀 = 1
var grid_pos: Vector2i  # 필드 관리자가 심을 때 주입해줌
var fruit_level: int = 1


func _ready() -> void:
	if randi_range(1, 2) == 1:
		animated_sprite_2d.flip_h = true
	Global.time_stop_signal.connect(stop_growing)
	Global.time_start_signal.connect(start_growing)
	Global.all_stat_refresh.connect(plants_setting)
	plants_start()

func plants_setting():
	grow_time = Global.gt_total_tomato
	amount = Global.fa_total_tomato
	bgt = Global.bgt_total_tomato
	
func plants_start():
	plants_setting()
	base_grow_time = grow_time
	current_bgt = bgt
	
var is_bgt = true
var growable = true
func stop_growing():
	growable = false

func start_growing():
	growable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if growable:
		base_grow_time -= delta
		if is_bgt:
			if base_grow_time <= 0:
				plants_level = 4
			elif base_grow_time <= grow_time * 0.33:
				plants_level = 3
			elif base_grow_time <= grow_time * 0.66:
				plants_level = 2
			plants_level_check()
		else:
			current_bgt -= delta
			if current_bgt <= 0:
				fruit_level = 3
			elif current_bgt <= bgt * 0.5:
				fruit_level = 2
			else:
				fruit_level = 1
			fruit_level_check()
			
func fruit_level_check():
	match fruit_level:
		1:
			animated_sprite_2d.play("4")
			$Area2D/CollisionShape2D.disabled = true
		2:
			animated_sprite_2d.play("4-2")
			$Area2D/CollisionShape2D.disabled = true
		3:
			animated_sprite_2d.play("4-3")
			$Area2D/CollisionShape2D.disabled = false

func plants_level_check():
	match plants_level:
		1:
			animated_sprite_2d.play("1")
			z_as_relative = false
			z_index = -1
		2:
			animated_sprite_2d.play("2")
			z_as_relative = false
			z_index = 0
		3:
			animated_sprite_2d.play("3")
		4:
			animated_sprite_2d.play("4")
			is_bgt = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_harvest()

func _harvest() -> void:
	Global.stat_refresh()
	var parent = get_tree().current_scene
	var node = parent.get_child(9)
	var item_position = Vector2(grid_pos.x * 128 + 64, grid_pos.y * 128 + 30)
	var da_amount = Global.da_amount_cul("tomato")
	for i in range (da_amount):
		var item = preload("res://scene/plants/plants_item/tomato_item.tscn").instantiate()
		item.set("spawn_position", item_position)
		node.add_child(item)
	
	animated_sprite_2d.play("4")
	current_bgt = Global.bgt_total_corn
	fruit_level = 1
	$Area2D/CollisionShape2D.disabled = true


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	Global.add_sa(crop_id, 1)  # 기존 동작 그대로 유지 (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	
	self.queue_free()
