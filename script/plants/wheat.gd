extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var grow_time
var amount
var base_grow_time
var plants_level = 1

var crop_id: int = 1  # 쌀 = 1
var grid_pos: Vector2i  # 필드 관리자가 심을 때 주입해줌

func _ready() -> void:
	Global.all_stat_refresh.connect(plants_setting)
	plants_setting()

func plants_setting():
	grow_time = Global.gt_total_wheat
	base_grow_time = grow_time
	amount = Global.fa_total_wheat
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	base_grow_time -= delta
	if base_grow_time <= 0:
		plants_level = 4
	elif base_grow_time <= grow_time * 0.33:
		plants_level = 3
	elif base_grow_time <= grow_time * 0.66:
		plants_level = 2
	plants_level_check()

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
			$Area2D/CollisionShape2D.disabled = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_harvest()

func _harvest() -> void:
	var item = preload("res://scene/plants/plants_item/wheat_item.tscn").instantiate()
	var parent = get_tree().current_scene
	var node = parent.get_child(4)
	var item_position = Vector2(grid_pos.x * 128 + 64, grid_pos.y * 128 + 30)
	item.set("spawn_position", item_position)
	node.add_child(item)
	
	Global.add_sa(crop_id, 1)  # 기존 동작 그대로 유지 (수확량 1개 고정)
	Global.clear_occupied(grid_pos)
	
	self.queue_free()
