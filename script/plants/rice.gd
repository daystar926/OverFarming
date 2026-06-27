extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var grow_time
var amount
var base_grow_time
var plants_level = 1

func _ready() -> void:
	Global.all_stat_refresh.connect(plants_setting)
	plants_setting()

func plants_setting():
	grow_time = Global.gt_total_rice
	base_grow_time = grow_time
	amount = Global.fa_total_rice

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
		2:
			animated_sprite_2d.play("2")
		3:
			animated_sprite_2d.play("3")
		4:
			animated_sprite_2d.play("4")
			$Area2D/CollisionShape2D.disabled = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var item = preload("res://scene/rice_item.tscn").instantiate()
		var parent = get_parent()
		parent.add_child(item)
		Global.add_sa(1, 1)
		self.queue_free()
		
